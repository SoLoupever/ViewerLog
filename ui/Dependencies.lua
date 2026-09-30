local addonName, ns = ...

-- Section "Dépendances" du panneau : active/désactive les addons
-- satellites de la suite ViewerLog (colonne gauche) et AltViewerLog
-- (colonne droite). Colonnes indépendantes, cf. commentaire des tables
-- ci-dessous pour la logique de cascade/symétrie.

ns.UI = ns.UI or {}

-- ── Dépendances optionnelles ─────────────────────────────────────
-- Deux colonnes indépendantes :
--   · Gauche  = modules ViewerLog (ViewerLog_X). Basculer une case ici
--     agit AUSSI sur le module AltViewerLog associé (avlName) :
--       - décocher ViewerLog_Guild → décoche AltViewerLog_GuildeLog (cascade)
--       - cocher   ViewerLog_Guild → coche   AltViewerLog_GuildeLog (symétrique)
--   · Droite  = AltViewerLog + ses modules (AltViewerLog_X). Basculer une
--     case ici n'agit QUE sur ce module Alt, sans jamais toucher ViewerLog.
-- L'activation/désactivation d'un addon ne prend effet qu'au /reload
-- suivant → popup VL_RELOAD_UI après chaque bascule.
-- avlName = contrepartie AltViewerLog à faire suivre (cascade/symétrie).
-- Monnaie et Recette n'ont PAS d'addon AltViewerLog_* dédié (la partie
-- recettes vit dans AltViewerLog_Professions) → avlName = nil.
local VL_MODULES = {
    { vlName = "ViewerLog_Tooltip",     avlName = nil,                        labelKey = "DEP_TOOLTIP" },
    { vlName = "ViewerLog_Guild",       avlName = "AltViewerLog_GuildeLog",   labelKey = "DEP_GUILD"   },
    { vlName = "ViewerLog_Reput",       avlName = "AltViewerLog_Reput",       labelKey = "DEP_REPUT"   },
    { vlName = "ViewerLog_Professions", avlName = "AltViewerLog_Professions", labelKey = "DEP_PROF"    },
    { vlName = "ViewerLog_Monnaie",     avlName = nil,                        labelKey = "DEP_MONNAIE" },
    { vlName = "ViewerLog_Recette",     avlName = nil,                        labelKey = "DEP_RECETTE" },
    { vlName = "ViewerLog_Housing",     avlName = nil,                        labelKey = "DEP_HOUSING" },
    { vlName = "ViewerLog_Reminder",    avlName = nil,                        labelKey = "DEP_REMINDER" },
}

-- Colonne droite : uniquement les addons AltViewerLog qui existent réellement
-- (cœur + plugins). Graphique n'a pas de contrepartie ViewerLog (il lit les
-- données du cœur ViewerLog) : il reste donc purement à droite.
local AVL_MODULES = {
    { avlName = "AltViewerLog",             labelKey = "DEP_AVL_CORE"  },
    { avlName = "AltViewerLog_GuildeLog",   labelKey = "DEP_AVL_GUILD" },
    { avlName = "AltViewerLog_Reput",       labelKey = "DEP_AVL_REPUT" },
    { avlName = "AltViewerLog_Professions", labelKey = "DEP_AVL_PROF"  },
    { avlName = "AltViewerLog_Graph",       labelKey = "DEP_AVL_GRAPH" },
}

-- L'addon existe-t-il dans la liste (installé, activé ou non) ?
local function AddonExists(name)
    if not C_AddOns or not C_AddOns.GetAddOnInfo then return false end
    local ok, info = pcall(C_AddOns.GetAddOnInfo, name)
    return ok and info ~= nil
end

-- État activé/désactivé. Plusieurs signatures essayées (l'API a changé de
-- forme selon les versions), repli sur IsAddOnLoaded.
local function AddonIsEnabled(name)
    if not C_AddOns then return false end
    if C_AddOns.GetAddOnEnableState then
        local ok, state = pcall(C_AddOns.GetAddOnEnableState, name)
        if ok and type(state) == "number" then return state ~= 0 end
        local ok2, state2 = pcall(C_AddOns.GetAddOnEnableState, nil, name)
        if ok2 and type(state2) == "number" then return state2 ~= 0 end
    end
    if C_AddOns.IsAddOnLoaded then
        local ok3, loaded = pcall(C_AddOns.IsAddOnLoaded, name)
        if ok3 then return loaded end
    end
    return false
end

local function SetAddonEnabled(name, enabled)
    if not C_AddOns or not AddonExists(name) then return false end
    local fn = enabled and C_AddOns.EnableAddOn or C_AddOns.DisableAddOn
    if not fn then return false end
    return (pcall(fn, name))
end

-- Une ligne = une checkbox (même composant que les réglages infobulles).
-- Grisée et décochée si le module n'est pas installé.
-- refreshOther : callback appelé après une bascule pour resynchroniser
-- la colonne d'en face (une bascule gauche modifie aussi une case droite).

-- Colonne GAUCHE (ViewerLog) : cascade vers le module Alt associé.
local function BuildVLRow(parent, anchor, offX, offY, mod, refreshOther)
    local installed = AddonExists(mod.vlName)
    local cb = ns.UI.Checkbox(parent,
        ns.L(mod.labelKey),
        installed and ns.L("DEP_VL_TIP") or ns.L("DEP_NOT_INSTALLED"),
        anchor, offX, offY,
        function() return installed and AddonIsEnabled(mod.vlName) end,
        function(v)
            SetAddonEnabled(mod.vlName, v)
            -- Cascade (désactivation) et symétrie (réactivation) vers Alt.
            if mod.avlName then SetAddonEnabled(mod.avlName, v) end
            if refreshOther then refreshOther() end
            StaticPopup_Show("VL_RELOAD_UI")
        end)
    if not installed then ns.UI.SetCheckboxEnabled(cb, false) end
    return cb
end

-- Colonne DROITE (AltViewerLog) : agit uniquement sur ce module Alt.
local function BuildAVLRow(parent, anchor, offX, offY, mod)
    local installed = AddonExists(mod.avlName)
    local cb = ns.UI.Checkbox(parent,
        ns.L(mod.labelKey),
        installed and ns.L("DEP_AVL_TIP") or ns.L("DEP_NOT_INSTALLED"),
        anchor, offX, offY,
        function() return installed and AddonIsEnabled(mod.avlName) end,
        function(v)
            SetAddonEnabled(mod.avlName, v)
            StaticPopup_Show("VL_RELOAD_UI")
        end)
    if not installed then ns.UI.SetCheckboxEnabled(cb, false) end
    return cb
end

-- Construit la section complète (titre + cadre deux colonnes) sous
-- anchorAbove. Renvoie le cadre (pour ancrer la suite du panneau) et
-- une fonction Refresh à appeler à l'ouverture du panneau.
function ns.UI.BuildDependenciesSection(panel, anchorAbove, panelWidth)
    local C = ns.UI.Colors

    local secDep = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    secDep:SetPoint("TOPLEFT", anchorAbove, "BOTTOMLEFT", 0, -22)
    secDep:SetText(ns.L("SECTION_DEPENDENCIES"))
    secDep:SetTextColor(C.accent[1] + 0.15, C.accent[2] + 0.15, C.accent[3] + 0.05)

    local sepDepTitle = panel:CreateTexture(nil, "ARTWORK")
    sepDepTitle:SetHeight(1)
    sepDepTitle:SetPoint("TOPLEFT",  secDep, "BOTTOMLEFT", -2, -8)
    sepDepTitle:SetPoint("TOPRIGHT", panel,  "TOPRIGHT",  -8,  0)
    sepDepTitle:SetColorTexture(C.accentDim[1], C.accentDim[2], C.accentDim[3], 0.40)

    -- Cadre sombre / bordure violette (même habillage que les listes).
    -- Deux colonnes côte à côte : gauche = ViewerLog, droite = AltViewerLog.
    -- Hauteur : 8 lignes à gauche (dont Infobulle) → 280.
    local DEP_BOX_H   = 280
    local COL_RIGHT_X = 322
    local depBox = ns.UI.StyledFrame(panel, panelWidth - 16, DEP_BOX_H)
    depBox:SetPoint("TOPLEFT", sepDepTitle, "BOTTOMLEFT", 2, -10)
    -- Ancre droite en plus de la gauche : la largeur suit celle du panneau
    -- (redimensionnable, cf. ui/PanelResize.lua) au lieu de rester figée
    -- sur panelWidth pris à la construction.
    depBox:SetPoint("TOPRIGHT", sepDepTitle, "BOTTOMRIGHT", -2, -10)

    -- En-têtes de colonnes
    local hdrVL = depBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hdrVL:SetPoint("TOPLEFT", depBox, "TOPLEFT", 12, -10)
    hdrVL:SetText(ns.L("SECTION_DEP_VL"))
    hdrVL:SetTextColor(C.accent[1] + 0.2, C.accent[2] + 0.2, C.accent[3] + 0.1)

    local hdrAVL = depBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hdrAVL:SetPoint("TOPLEFT", depBox, "TOPLEFT", COL_RIGHT_X, -10)
    hdrAVL:SetText(ns.L("SECTION_DEP_AVL"))
    hdrAVL:SetTextColor(C.accent[1] + 0.2, C.accent[2] + 0.2, C.accent[3] + 0.1)

    -- Séparateur vertical entre les deux colonnes
    local depVSep = depBox:CreateTexture(nil, "ARTWORK")
    depVSep:SetWidth(1)
    depVSep:SetPoint("TOPLEFT",    depBox, "TOPLEFT",    COL_RIGHT_X - 12, -6)
    depVSep:SetPoint("BOTTOMLEFT", depBox, "BOTTOMLEFT", COL_RIGHT_X - 12,  6)
    depVSep:SetColorTexture(C.accentDim[1], C.accentDim[2], C.accentDim[3], 0.40)

    -- Ancres invisibles de tête pour chaque colonne (les lignes s'ancrent
    -- au BOTTOMLEFT de la précédente).
    local leftTopAnchor = CreateFrame("Frame", nil, depBox)
    leftTopAnchor:SetSize(1, 1)
    leftTopAnchor:SetPoint("TOPLEFT", depBox, "TOPLEFT", 12, -30)

    local rightTopAnchor = CreateFrame("Frame", nil, depBox)
    rightTopAnchor:SetSize(1, 1)
    rightTopAnchor:SetPoint("TOPLEFT", depBox, "TOPLEFT", COL_RIGHT_X, -30)

    -- Resynchronisation de la colonne droite après une bascule gauche
    -- (déclarée avant les lignes gauche qui la référencent en callback).
    local depAVLRows
    local function RefreshAVLRows()
        if not depAVLRows then return end
        for i, mod in ipairs(AVL_MODULES) do
            local cb = depAVLRows[i]
            local installed = AddonExists(mod.avlName)
            ns.UI.SetCheckboxEnabled(cb, installed)
            cb:SetChecked(installed and AddonIsEnabled(mod.avlName))
        end
    end

    -- Colonne gauche (ViewerLog) — cascade/symétrie vers Alt.
    local depVLRows = {}
    local prevRow = leftTopAnchor
    for i, mod in ipairs(VL_MODULES) do
        depVLRows[i] = BuildVLRow(depBox, prevRow, 0, (i == 1) and 0 or -8, mod, RefreshAVLRows)
        prevRow = depVLRows[i]
    end

    -- Colonne droite (AltViewerLog) — indépendante.
    depAVLRows = {}
    prevRow = rightTopAnchor
    for i, mod in ipairs(AVL_MODULES) do
        depAVLRows[i] = BuildAVLRow(depBox, prevRow, 0, (i == 1) and 0 or -8, mod)
        prevRow = depAVLRows[i]
    end

    local function Refresh()
        -- Colonne gauche (ViewerLog)
        for i, mod in ipairs(VL_MODULES) do
            local cb = depVLRows[i]
            local installed = AddonExists(mod.vlName)
            ns.UI.SetCheckboxEnabled(cb, installed)
            cb:SetChecked(installed and AddonIsEnabled(mod.vlName))
        end
        -- Colonne droite (AltViewerLog)
        RefreshAVLRows()
    end

    return { bottomAnchor = depBox, Refresh = Refresh }
end
