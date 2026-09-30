local addonName, pluginNs = ...
local core  = _G.AltViewerLogAPI
local vlAPI = _G.ViewerLogAPI

-- Détection des recettes housing connues.
-- Pour chaque métier d'un perso, détermine les recettes connues et les stocke
-- dans professions[].knownRecipes (clé = itemID). Deux sources, dans l'ordre :
--   1. Repli statique (data/professions/*.lua + IsPlayerSpell) : fenêtre fermée.
--   2. Découverte auto (HousingCatalog.lua) : fenêtre ouverte, exhaustive.
-- Ce module est l'unique propriétaire de knownRecipes.

-- ── Détection pour UNE profession ({name=, knownRecipes=}) ────────
function pluginNs.DetectKnownRecipes(profData)
    if not profData or not profData.name then return end
    profData.knownRecipes = profData.knownRecipes or {}
    local knownMap = profData.knownRecipes

    -- ── 1. Repli statique ──────────────────────────────────────────
    if pluginNs.RECIPE_DEFINITIONS then
        local defKey  = (pluginNs.PROF_RECIPE_KEY and pluginNs.PROF_RECIPE_KEY[profData.name]) or profData.name
        local profDef = pluginNs.RECIPE_DEFINITIONS[defKey]
        if profDef then
            local learnedSpellIDs = {}
            if C_TradeSkillUI.IsTradeSkillReady and C_TradeSkillUI.IsTradeSkillReady() then
                local allIDs = C_TradeSkillUI.GetAllRecipeIDs and C_TradeSkillUI.GetAllRecipeIDs()
                if allIDs then
                    for _, spellID in ipairs(allIDs) do
                        local rInfo = C_TradeSkillUI.GetRecipeInfo(spellID)
                        if rInfo and rInfo.learned then learnedSpellIDs[spellID] = true end
                    end
                end
            end
            local hasLearnedData = next(learnedSpellIDs) ~= nil

            for _, recipes in pairs(profDef) do
                for _, recipe in ipairs(recipes) do
                    if recipe.spellID and recipe.spellID > 0 then
                        if hasLearnedData then
                            knownMap[recipe.itemID] = learnedSpellIDs[recipe.spellID] or false
                        else
                            knownMap[recipe.itemID] = IsPlayerSpell(recipe.spellID) or false
                        end
                    end
                end
            end
        end
    end

    -- ── 2. Découverte automatique ───────────────────────────────────
    -- Ne fait rien fenêtre fermée (retourne nil) → repli statique seul.
    if pluginNs.DiscoverHousingRecipes then
        local discovered = pluginNs.DiscoverHousingRecipes(profData.name)
        if discovered then
            for _, entry in pairs(discovered) do
                if entry.itemID then
                    knownMap[entry.itemID] = entry.learned
                end
            end
        end
    end
end

-- ── Point d'accès unique aux données du perso courant (ViewerLogDB) ──
local function GetCurrentCharData()
    if vlAPI and vlAPI.GetCurrentCharData then
        return vlAPI.GetCurrentCharData()
    end
    return nil
end

-- ── Détection sur TOUS les métiers du perso courant ───────────────
-- Utilisé au login et par /vlhousing scan : IsPlayerSpell suffit pour
-- le repli statique même fenêtre fermée.
function pluginNs.DetectAllForCurrentChar()
    local charData = GetCurrentCharData()
    if not charData or not charData.professions then return end
    for _, p in ipairs(charData.professions) do
        pluginNs.DetectKnownRecipes(p)
    end
end

-- ── Résolution du métier ouvert (mirroir de AltViewerLog_Professions) ──
local function ForEachProf(callback)
    local p1, p2, ar, fi, co = GetProfessions()
    if p1 then callback(p1) end
    if p2 then callback(p2) end
    if ar then callback(ar) end
    if fi then callback(fi) end
    if co then callback(co) end
end

local function ResolveOpenProfName()
    local baseInfo = C_TradeSkillUI.GetBaseProfessionInfo and C_TradeSkillUI.GetBaseProfessionInfo()
    if baseInfo and baseInfo.professionName and baseInfo.professionName ~= "" then
        return baseInfo.professionName
    end
    if C_TradeSkillUI.GetTradeSkillDisplayName then
        local n = C_TradeSkillUI.GetTradeSkillDisplayName()
        if n and n ~= "" then return n end
    end
    return nil
end

-- ── TRADE_SKILL_SHOW : détection du métier ouvert ─────────────────
-- Délai 1 s : laisse AltViewerLog_Professions faire son scan (qui préserve
-- knownRecipes) avant de récupérer l'entrée fraîche et de la mettre à jour.
local tradeFrame = CreateFrame("Frame")
tradeFrame:RegisterEvent("TRADE_SKILL_SHOW")
tradeFrame:SetScript("OnEvent", function()
    if not ViewerLogDB then return end
    C_Timer.After(1.0, function()
        if not (C_TradeSkillUI.IsTradeSkillReady and C_TradeSkillUI.IsTradeSkillReady()) then return end
        local profName = ResolveOpenProfName()
        if not profName then return end

        local charData = GetCurrentCharData()
        if not charData then return end
        charData.professions = charData.professions or {}

        -- Entrée fraîche au moment de l'écriture (peut avoir été remplacée).
        local entry
        for _, p in ipairs(charData.professions) do
            if p.name == profName then entry = p; break end
        end
        if not entry then
            entry = { name = profName, knownRecipes = {} }
            charData.professions[#charData.professions + 1] = entry
        end

        pluginNs.DetectKnownRecipes(entry)
        if core and core.DBG then
            core.DBG(string.format("|cff00aaff[VL-Housing]|r " .. pluginNs.L("DBG_PASSIVE_SCAN"), profName))
        end
        -- Pas de refresh direct : la vue Métiers se rafraîchit sur ce même
        -- TRADE_SKILL_SHOW et GetHousingRecipes redétecte le perso au rendu.
    end)
end)

-- ── PLAYER_LOGIN : détection après le scan des métiers ────────────
-- ViewerLog_Professions peuple .professions à +8 s → on détecte à +11 s.
local loginFrame = CreateFrame("Frame")
loginFrame:RegisterEvent("PLAYER_LOGIN")
loginFrame:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN")
    C_Timer.After(11, pluginNs.DetectAllForCurrentChar)
end)
