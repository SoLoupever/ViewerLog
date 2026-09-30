local addonName, ns = ...

-- Injection UI : barre + grille "Recettes" dans AltViewerLog_Professions.
-- Fonctionnalité isolée ici (scan + affichage) ; l'hôte expose
-- _G.AltViewerLog_ProfessionsAPI.RegisterRowInjector(fn) pour accrocher du
-- contenu par ligne de métier, sans connaître ViewerLog_Recette.
-- EXPANSION_LIST / GetTierColor lus sur cette même API (pas de duplication).
-- Optionnel : API absente → ne fait rien (garde en bas), le scan continue.

-- ── Pools ─────────────────────────────────────────────────────────
local barPool,    barUsed    = {}, 0
local iconPool,   iconUsed   = {}, 0
local headerPool, headerUsed = {}, 0

-- ── Une seule grille dépliée à la fois ────────────────────────────
-- Plusieurs centaines de recettes possibles par métier ; 2 grilles ouvertes
-- ensemble saturaient le rendu de l'hôte.
local recipeExpanded = {}

local function RecipeKey(realmName, charName, profName)
    return realmName .. "||" .. charName .. "||" .. profName
end

-- ── Cycle de rendu ────────────────────────────────────────────────
-- L'injecteur est appelé une fois par ligne de métier. Sans hook "fin de
-- rendu" côté hôte, un timer à délai 0 (réarmé à chaque appel) sert de
-- repère de fin de passe : il ne se déclenche qu'après tous les appels
-- synchrones, pour cacher les régions poolées inutilisées.
local _cleanupTimer = nil
local _passActive = false

local function BeginPassIfNeeded()
    if not _passActive then
        _passActive = true
        barUsed, iconUsed, headerUsed = 0, 0, 0
    end
end

local function HideUnused()
    for i = barUsed + 1, #barPool do barPool[i].bg:Hide() end
    for i = iconUsed + 1, #iconPool do iconPool[i]:Hide() end
    for i = headerUsed + 1, #headerPool do
        headerPool[i].sep:Hide(); headerPool[i].fs:Hide()
    end
end

local function ScheduleCleanup()
    if _cleanupTimer then _cleanupTimer:Cancel() end
    _cleanupTimer = C_Timer.NewTimer(0, function()
        _cleanupTimer = nil
        _passActive = false
        HideUnused()
    end)
end

-- Rattache un nom de palier à une entrée d'EXPANSION_LIST (ordre/couleur
-- cohérents). nil si aucune correspondance → groupe "Autres".
local function MatchExpansion(tierName, expansionList)
    if not tierName or not expansionList then return nil end
    for _, exp in ipairs(expansionList) do
        if tierName:find(exp.name, 1, true) then return exp.name end
        for _, alias in ipairs(exp.aliases or {}) do
            if tierName:find(alias, 1, true) then return exp.name end
        end
    end
    return nil
end

-- ── Grille dépliée ────────────────────────────────────────────────
-- Toutes les recettes (connues et non), groupées par extension. Icônes et
-- en-têtes poolés.
local function RenderGrid(parent, profRecipes, LEFT_PAD, offsetY, contentW, expansionList, getTierColor)
    contentW = contentW or 660
    local gridLeft   = LEFT_PAD + 14
    local gridAvailW = contentW - gridLeft - 10
    local ICON_SIZE, ICON_GAP = 30, 4
    local ICONS_PER_ROW = math.max(4, math.min(16,
        math.floor((gridAvailW + ICON_GAP) / (ICON_SIZE + ICON_GAP))
    ))

    local OTHER_KEY = "__other__"
    local groups, groupOrder = {}, {}
    if expansionList then
        for _, exp in ipairs(expansionList) do
            groups[exp.name] = {}
            groupOrder[#groupOrder + 1] = exp.name
        end
    end
    groups[OTHER_KEY] = {}
    groupOrder[#groupOrder + 1] = OTHER_KEY

    local anyEntry = false
    for recipeID, e in pairs(profRecipes.entries or {}) do
        anyEntry = true
        local expName = MatchExpansion(e.tier, expansionList) or OTHER_KEY
        local g = groups[expName]
        g[#g + 1] = { id = recipeID, name = e.name, icon = e.icon, learned = e.learned }
    end
    if not anyEntry then return offsetY end

    offsetY = offsetY - 6

    for _, expName in ipairs(groupOrder) do
        local list = groups[expName]
        if #list > 0 then
            table.sort(list, function(a, b)
                if a.learned ~= b.learned then return a.learned end
                return (a.name or "") < (b.name or "")
            end)

            local known = 0
            for _, r in ipairs(list) do if r.learned then known = known + 1 end end

            local color = (expName ~= OTHER_KEY and getTierColor and getTierColor(expName))
                or { r = 0.5, g = 0.5, b = 0.5 }
            local label = (expName ~= OTHER_KEY) and expName or ns.L("RECIPES_OTHER")

            headerUsed = headerUsed + 1
            local hSlot = headerPool[headerUsed]
            if not hSlot then
                hSlot = {}
                hSlot.sep = parent:CreateTexture(nil, "ARTWORK")
                hSlot.sep:SetHeight(1)
                hSlot.fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                headerPool[headerUsed] = hSlot
            end

            hSlot.sep:ClearAllPoints()
            hSlot.sep:SetPoint("TOPLEFT", gridLeft, offsetY)
            hSlot.sep:SetWidth(gridAvailW)
            hSlot.sep:SetColorTexture(color.r, color.g, color.b, 0.5)
            hSlot.sep:Show()

            hSlot.fs:ClearAllPoints()
            hSlot.fs:SetPoint("TOPLEFT", gridLeft, offsetY - 2)
            hSlot.fs:SetTextColor(color.r, color.g, color.b)
            hSlot.fs:SetText(string.format("%s  %d/%d", label, known, #list))
            hSlot.fs:Show()

            offsetY = offsetY - 16

            local col, row = 0, 0
            for _, r in ipairs(list) do
                iconUsed = iconUsed + 1
                local iconFrame = iconPool[iconUsed]
                if not iconFrame then
                    iconFrame = CreateFrame("Button", nil, parent, "BackdropTemplate")
                    iconFrame:SetSize(ICON_SIZE, ICON_SIZE)
                    iconFrame:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
                    iconFrame.tex = iconFrame:CreateTexture(nil, "ARTWORK")
                    iconFrame.tex:SetPoint("TOPLEFT", 2, -2); iconFrame.tex:SetPoint("BOTTOMRIGHT", -2, 2)
                    iconFrame.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
                    iconPool[iconUsed] = iconFrame
                end

                iconFrame:ClearAllPoints()
                iconFrame:SetPoint("TOPLEFT",
                    gridLeft + col * (ICON_SIZE + ICON_GAP),
                    offsetY - row * (ICON_SIZE + ICON_GAP))
                iconFrame.tex:SetTexture(r.icon or "Interface\\Icons\\INV_Misc_QuestionMark")

                if r.learned then
                    iconFrame:SetBackdropBorderColor(0.10, 0.85, 0.20, 1)
                    iconFrame:SetBackdropColor(0.04, 0.14, 0.04, 1)
                    iconFrame.tex:SetVertexColor(1, 1, 1)
                else
                    iconFrame:SetBackdropBorderColor(0.70, 0.10, 0.10, 0.9)
                    iconFrame:SetBackdropColor(0.14, 0.04, 0.04, 1)
                    iconFrame.tex:SetVertexColor(0.35, 0.35, 0.35)
                end

                local rName = r.name or "?"
                iconFrame:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetText(rName, 1, 1, 1)
                    GameTooltip:Show()
                end)
                iconFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
                iconFrame:Show()

                col = col + 1
                if col >= ICONS_PER_ROW then col = 0; row = row + 1 end
            end

            local totalRows = math.ceil(#list / ICONS_PER_ROW)
            offsetY = offsetY - totalRows * (ICON_SIZE + ICON_GAP) - 10
        end
    end

    return offsetY
end

-- ── L'injecteur ───────────────────────────────────────────────────
-- Contrat de l'hôte : reçoit (parent, profData, realmName, charName,
-- anchorFrame, LEFT_PAD, offsetY, contentW), retourne offsetY après son
-- contenu. Appelé une fois par ligne de métier, protégé par pcall côté hôte.
local function InjectRecipeBar(parent, profData, realmName, charName, anchorFrame, LEFT_PAD, offsetY, contentW)
    BeginPassIfNeeded()

    local pubProf = _G.AltViewerLog_ProfessionsAPI
    local expansionList = pubProf and pubProf.EXPANSION_LIST
    local getTierColor  = pubProf and pubProf.GetTierColor

    local rKey        = RecipeKey(realmName, charName, profData.name)
    local isExpanded   = recipeExpanded[rKey] or false

    barUsed = barUsed + 1
    local bSlot = barPool[barUsed]
    if not bSlot then
        bSlot = {}
        bSlot.bg = CreateFrame("Button", nil, parent, "BackdropTemplate")
        bSlot.bg:SetSize(280, 18)
        bSlot.bg:SetBackdrop({ bgFile="Interface\\Buttons\\WHITE8x8", edgeFile="Interface\\Buttons\\WHITE8x8", edgeSize=1 })
        bSlot.bg:SetBackdropColor(0.08, 0.08, 0.12, 0.85); bSlot.bg:SetBackdropBorderColor(0.28, 0.28, 0.38, 1)

        -- Même agencement que le bouton Housing (arrowTex / texte / mini-barre).
        bSlot.arrowTex = bSlot.bg:CreateTexture(nil, "OVERLAY")
        bSlot.arrowTex:SetSize(14, 14); bSlot.arrowTex:SetPoint("LEFT", 3, 0)

        bSlot.textFS = bSlot.bg:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        bSlot.textFS:SetPoint("LEFT", 21, 0); bSlot.textFS:SetTextColor(0.65, 0.65, 0.85)

        bSlot.miniBarBg = bSlot.bg:CreateTexture(nil, "BACKGROUND")
        bSlot.miniBarBg:SetSize(60, 4); bSlot.miniBarBg:SetPoint("RIGHT", -6, 0); bSlot.miniBarBg:SetColorTexture(0.15, 0.15, 0.20, 1)
        bSlot.miniBarFill = bSlot.bg:CreateTexture(nil, "ARTWORK")
        bSlot.miniBarFill:SetPoint("LEFT", bSlot.miniBarBg, "LEFT", 0, 0)

        barPool[barUsed] = bSlot
    end

    bSlot.bg:ClearAllPoints()
    if anchorFrame then
        bSlot.bg:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 10, 0)
    else
        -- Pas de bouton Housing pour ce métier : la barre Recettes prend sa place.
        bSlot.bg:SetPoint("TOPLEFT", parent, "TOPLEFT", LEFT_PAD + 14, offsetY)
    end
    bSlot.bg:Show()

    local recipeData  = ns.GetRecipes(charName, realmName)
    local profRecipes = recipeData and recipeData[profData.name]
    local hasData      = profRecipes and profRecipes.entries and profRecipes.total and profRecipes.total > 0

    if hasData then
        local rKnown, rTotal = profRecipes.known or 0, profRecipes.total

        bSlot.arrowTex:SetAtlas(isExpanded and "housing-floor-arrow-down-default" or "housing-floor-arrow-up-default")
        bSlot.textFS:SetText(string.format(ns.L("RECIPES_LABEL"), rKnown, rTotal))

        if rTotal > 0 then
            local fillW = math.max(math.floor((rKnown / rTotal) * 60), 1)
            bSlot.miniBarFill:SetSize(fillW, 4)
            local pct = rKnown / rTotal
            bSlot.miniBarFill:SetColorTexture(pct>=1 and 0 or 0.45, pct>=1 and 0.85 or 0.55, pct>=1 and 0.35 or 1.00, 0.9)
            bSlot.miniBarBg:Show(); bSlot.miniBarFill:Show()
        else
            bSlot.miniBarBg:Hide(); bSlot.miniBarFill:Hide()
        end

        bSlot.bg:SetScript("OnEnter", function(self)
            self:SetBackdropBorderColor(0.45, 0.45, 0.65, 1)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(string.format(ns.L("RECIPES_TOOLTIP"), rKnown, rTotal), 1, 1, 1)
            GameTooltip:AddLine(isExpanded and ns.L("RECIPES_FOLD") or ns.L("RECIPES_UNFOLD"), 0.8, 0.8, 1)
            GameTooltip:Show()
        end)
        bSlot.bg:SetScript("OnLeave", function(self)
            self:SetBackdropBorderColor(0.28, 0.28, 0.38, 1)
            GameTooltip:Hide()
        end)

        local capturedKey = rKey
        bSlot.bg:SetScript("OnClick", function()
            local willExpand = not recipeExpanded[capturedKey]
            wipe(recipeExpanded)
            if willExpand then recipeExpanded[capturedKey] = true end
            if pubProf and pubProf.Refresh then pubProf.Refresh() end
        end)
    else
        bSlot.arrowTex:SetTexture(nil)
        bSlot.miniBarBg:Hide(); bSlot.miniBarFill:Hide()
        bSlot.textFS:SetTextColor(0.5, 0.5, 0.5, 1)
        bSlot.textFS:SetText(ns.L("RECIPES_NO_DATA"))
        bSlot.bg:SetScript("OnEnter", nil)
        bSlot.bg:SetScript("OnLeave", nil)
        bSlot.bg:SetScript("OnClick", nil)
    end

    if hasData and isExpanded then
        offsetY = RenderGrid(parent, profRecipes, LEFT_PAD, offsetY, contentW, expansionList, getTierColor)
    end

    ScheduleCleanup()
    return offsetY
end

-- ── Enregistrement ─────────────────────────────────────────────────
-- API hôte absente → ne fait rien (le scan continue).
if _G.AltViewerLog_ProfessionsAPI and _G.AltViewerLog_ProfessionsAPI.RegisterRowInjector then
    _G.AltViewerLog_ProfessionsAPI.RegisterRowInjector(InjectRecipeBar)
end
