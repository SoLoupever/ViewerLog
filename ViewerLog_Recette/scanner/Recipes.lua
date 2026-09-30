local addonName, ns = ...

-- Scanner recettes de métier.
-- Capture toutes les recettes (connues et non) du métier ouvert via
-- C_TradeSkillUI : nom, icône, statut appris, palier d'extension.
-- La liste n'est lisible que fenêtre de métier ouverte (ouverture par code
-- = protégée) → aucun scan passif ici.
-- Palier par recette via GetTradeSkillLineForRecipe(recipeID).
-- GetAllRecipeIDs() ne renvoie que le palier affiché → stockage FUSIONNÉ :
-- charData.recipes[profName].entries s'enrichit scan après scan (complet une
-- fois chaque onglet ouvert). Séparé de charData.professions pour ne pas
-- créer de dépendance croisée avec AltViewerLog_Professions.
-- formatVersion : reconstruit charData.recipes si la forme a changé.
-- Déclencheurs (Init.lua) : TRADE_SKILL_SHOW (0.5 s), TRADE_SKILL_LIST_UPDATE
-- (debounce 1 s). Pas de scan au login/logout.

local time = time
local FORMAT_VERSION = 2

-- ── Identification du métier actuellement ouvert ──────────────────
-- Clé de premier niveau (charData.recipes[profName]), distincte du palier
-- par recette (tier, plus bas).
local function GetOpenProfessionName()
    if C_TradeSkillUI.GetBaseProfessionInfo then
        local info = C_TradeSkillUI.GetBaseProfessionInfo()
        if info then
            local n = info.professionName or info.parentProfessionName or info.name
            if n and n ~= "" then return n end
        end
    end
    if C_TradeSkillUI.GetTradeSkillLine then
        local _, name = C_TradeSkillUI.GetTradeSkillLine()
        if name and name ~= "" then return name end
    end
    return nil
end

-- ── Scan du métier actuellement ouvert (fusion, pas remplacement) ──
local function ExecuteRecipeScan()
    if not C_TradeSkillUI or not C_TradeSkillUI.GetAllRecipeIDs then return end
    if C_TradeSkillUI.IsTradeSkillReady and not C_TradeSkillUI.IsTradeSkillReady() then return end

    local profName = GetOpenProfessionName()
    if not profName then return end

    local vlAPI = _G.ViewerLogAPI
    if not vlAPI or not vlAPI.GetCurrentCharData then return end
    local charData = vlAPI.GetCurrentCharData()
    if not charData then return end

    local recipeIDs = C_TradeSkillUI.GetAllRecipeIDs()
    if not recipeIDs or #recipeIDs == 0 then return end

    charData.recipes = charData.recipes or {}
    local slot = charData.recipes[profName]
    if not slot or slot.formatVersion ~= FORMAT_VERSION or type(slot.entries) ~= "table" then
        slot = { entries = {}, total = 0, known = 0, formatVersion = FORMAT_VERSION, updatedAt = 0 }
    end

    local hasTierLookup = C_TradeSkillUI.GetTradeSkillLineForRecipe ~= nil
    local changed = false

    for _, recipeID in ipairs(recipeIDs) do
        local info = C_TradeSkillUI.GetRecipeInfo(recipeID)
        if info then
            local learned = info.learned or false
            local icon    = info.icon or (GetSpellTexture and GetSpellTexture(recipeID)) or nil

            -- Palier de cette recette précisément (chaque recette vient de
            -- sa propre extension), pas celui du métier global.
            local tier = profName
            if hasTierLookup then
                local _, tierName = C_TradeSkillUI.GetTradeSkillLineForRecipe(recipeID)
                if tierName and tierName ~= "" then tier = tierName end
            end

            local existing = slot.entries[recipeID]
            if not existing
                or existing.learned ~= learned
                or existing.tier    ~= tier
                or existing.name    ~= info.name
                or existing.icon    ~= icon
            then
                slot.entries[recipeID] = { name = info.name, icon = icon, learned = learned, tier = tier }
                changed = true
            end
        end
    end

    if changed then
        local total, known = 0, 0
        for _, e in pairs(slot.entries) do
            total = total + 1
            if e.learned then known = known + 1 end
        end
        slot.total     = total
        slot.known     = known
        slot.updatedAt = time()
        charData.recipes[profName] = slot
    end
end

-- ── Debounce TRADE_SKILL_LIST_UPDATE ──────────────────────────────
local _listTimer = nil

-- Scan du métier ouvert. debounce = true → délai 1 s (TRADE_SKILL_LIST_UPDATE),
-- sinon scan immédiat (TRADE_SKILL_SHOW).
function ns.ScanOpenProfessionRecipes(debounce)
    if debounce then
        if _listTimer then _listTimer:Cancel() end
        _listTimer = C_Timer.NewTimer(1.0, function()
            _listTimer = nil
            ExecuteRecipeScan()
        end)
    else
        if _listTimer then _listTimer:Cancel(); _listTimer = nil end
        ExecuteRecipeScan()
    end
end

-- ── Accesseur ──────────────────────────────────────────────────────
-- Retourne { [professionName] = { entries = {[recipeID]={name,icon,learned,tier}},
-- total, known, updatedAt } } ou nil.
function ns.GetRecipes(charName, realmName)
    local vlAPI = _G.ViewerLogAPI
    local d = vlAPI and vlAPI.GetCharacter and vlAPI.GetCharacter(charName, realmName)
    return d and d.recipes
end
