local addonName, ns = ...

-- Panneau principal de paramètres (remplace le panneau Blizzard).
-- Assemble les sections construites par les autres modules ui/* :
-- infobulles, rappels, dépendances, liste persos, liste guildes.
-- Clic gauche sur le bouton minimap = ouvre/ferme (cf. ui/Minimap.lua).

ns.UI = ns.UI or {}

local PANEL_W = 660
local PANEL_H = 1032 -- +150 : section Rappels (2 checkboxes) + 8e ligne de dépendance (ViewerLog_Reminder)
local COL_L_W = 290
local COL_R_X = COL_L_W + 16
local COL_R_W = PANEL_W - COL_R_X - 12
local LIST_BOTTOM = 12 -- marge sous les listes, en bas du panneau

-- Bornes de redimensionnement (cf. ui/PanelResize.lua). Largeur minimale
-- = largeur par défaut : en dessous, le cadre Dépendances (largeur fixe,
-- ui/Dependencies.lua) et l'aperçu infobulle (colonne droite, position
-- fixe) déborderaient du panneau. La hauteur peut librement rétrécir,
-- les listes perso/guilde étant scrollables.
local RESIZE_MIN_W, RESIZE_MAX_W = PANEL_W, PANEL_W + 400
local RESIZE_MIN_H, RESIZE_MAX_H = 650, 1500

local panel = nil

local function BuildPanel()
    if panel then return panel end

    local C = ns.UI.Colors

    panel = CreateFrame("Frame", "VL_MinimapPanel", UIParent, "BackdropTemplate")

    local savedW = ViewerLogDB.settings and ViewerLogDB.settings.panelWidth
    local savedH = ViewerLogDB.settings and ViewerLogDB.settings.panelHeight
    savedW = savedW and math.max(RESIZE_MIN_W, math.min(RESIZE_MAX_W, savedW)) or PANEL_W
    savedH = savedH and math.max(RESIZE_MIN_H, math.min(RESIZE_MAX_H, savedH)) or PANEL_H
    panel:SetSize(savedW, savedH)
    panel:SetFrameStrata("HIGH")
    panel:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 2,
    })
    panel:SetBackdropColor(C.bg[1], C.bg[2], C.bg[3], C.bg[4])
    panel:SetBackdropBorderColor(C.border[1], C.border[2], C.border[3], 1)
    panel:SetMovable(true)
    panel:EnableMouse(true)
    panel:RegisterForDrag("LeftButton")
    panel:SetScript("OnDragStart", function(s) s:StartMoving() end)
    panel:SetScript("OnDragStop",  function(s) s:StopMovingOrSizing() end)
    panel:SetClampedToScreen(true)
    panel:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -8, 0)
    panel:Hide()
    table.insert(UISpecialFrames, "VL_MinimapPanel")

    -- ── Titre ─────────────────────────────────────────────────
    local titleFS = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    titleFS:SetPoint("TOPLEFT", 12, -12)
    titleFS:SetText("|cff9955ffViewer|r|cffccaaffLog|r")

    local closeBtn = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() panel:Hide() end)

    -- ── Section Infobulles (checkboxes) ───────────────────────
    local secTT = ns.UI.SectionTitle(panel, ns.L("SECTION_TOOLTIPS"), 10, -44)
    ns.UI.HSep(panel, secTT, -2, -8)

    local function S(key)
        return (ViewerLogDB.settings or {})[key]
    end
    local function SetS(key, val)
        ViewerLogDB.settings = ViewerLogDB.settings or {}
        ViewerLogDB.settings[key] = val
    end
    local function RefreshPreview()
        if panel._preview then panel._preview.Refresh() end
    end

    local cbIcons = ns.UI.Checkbox(panel,
        ns.L("CB_HIDE_ICONS"),
        ns.L("CB_HIDE_ICONS_TIP"),
        secTT, 0, -18,
        function() return S("hideTooltipIcons")    end,
        function(v) SetS("hideTooltipIcons", v);    RefreshPreview() end)

    local cbGuild = ns.UI.Checkbox(panel,
        ns.L("CB_HIDE_GUILD"),
        ns.L("CB_HIDE_GUILD_TIP"),
        cbIcons, 0, -10,
        function() return S("hideGuildTooltip")    end,
        function(v) SetS("hideGuildTooltip", v);    RefreshPreview() end)

    local cbWarband = ns.UI.Checkbox(panel,
        ns.L("CB_HIDE_WARBAND"),
        ns.L("CB_HIDE_WARBAND_TIP"),
        cbGuild, 0, -10,
        function() return S("hideWarbandTooltip")  end,
        function(v) SetS("hideWarbandTooltip", v);  RefreshPreview() end)

    local cbRealm = ns.UI.Checkbox(panel,
        ns.L("CB_HIDE_REALM"),
        ns.L("CB_HIDE_REALM_TIP"),
        cbWarband, 0, -10,
        function() return S("hideRealmTooltip")     end,
        function(v) SetS("hideRealmTooltip", v);     RefreshPreview() end)

    -- Désactivation "douce" (masquage immédiat) de l'infobulle. L'addon
    -- ViewerLog_Tooltip reste chargé et teste ce flag à chaque tooltip → pas
    -- de /reload dans un sens ni l'autre. Pour décharger complètement l'addon,
    -- la case dédiée reste dans la section Dépendances ci-dessous.
    -- Quand désactivée, les 4 cases ci-dessus n'ont plus d'effet : on les grise.
    local cbDisable
    local function UpdateTooltipDependents()
        local enabled = not S("disableTooltip")
        ns.UI.SetCheckboxEnabled(cbIcons,   enabled)
        ns.UI.SetCheckboxEnabled(cbGuild,   enabled)
        ns.UI.SetCheckboxEnabled(cbWarband, enabled)
        ns.UI.SetCheckboxEnabled(cbRealm,   enabled)
        if panel._preview then
            panel._preview:SetAlpha(enabled and 1 or 0.35)
        end
    end

    cbDisable = ns.UI.Checkbox(panel,
        ns.L("CB_DISABLE_TOOLTIP"),
        ns.L("CB_DISABLE_TOOLTIP_TIP"),
        cbRealm, 0, -16,
        function() return S("disableTooltip") end,
        function(v)
            SetS("disableTooltip", v)
            UpdateTooltipDependents()
        end)
    cbDisable.text:SetTextColor(1, 0.6, 0.6)

    -- ── Aperçu infobulle (colonne droite) ─────────────────────
    -- Ancré sur cbIcons (pas en absolu) pour rester aligné si la colonne
    -- de gauche change de hauteur.
    local PREVIEW_H = 105
    local preview = ns.UI.BuildTooltipPreview(panel, cbIcons, COL_R_X - 10, 0, COL_R_W, PREVIEW_H)
    panel._preview = preview

    -- ── Bouton Discord (sous l'aperçu, même colonne) ──────────────
    ns.UI.BuildDiscordButton(panel, preview, 0, -8, COL_R_W)

    -- ── Section Rappels (checkboxes) ────────────────────────────
    -- Réglages "doux" (ViewerLogDB.settings), lus par ViewerLog_Reminder
    -- via ViewerLogAPI.GetSetting — effet immédiat, pas de /reload.
    -- N'affecte pas le chargement de l'addon lui-même (cf. section
    -- Dépendances ci-dessous pour le désactiver entièrement).
    local secReminder = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    secReminder:SetPoint("TOPLEFT", cbDisable, "BOTTOMLEFT", 0, -22)
    secReminder:SetText(ns.L("SECTION_REMINDERS"))
    secReminder:SetTextColor(C.accent[1] + 0.15, C.accent[2] + 0.15, C.accent[3] + 0.05)
    ns.UI.HSep(panel, secReminder, -2, -8)

    local cbEventReminder = ns.UI.Checkbox(panel,
        ns.L("CB_EVENT_REMINDER"),
        ns.L("CB_EVENT_REMINDER_TIP"),
        secReminder, 0, -18,
        function() return not S("disableEventReminder") end,
        function(v) SetS("disableEventReminder", not v) end)

    local cbMailReminder = ns.UI.Checkbox(panel,
        ns.L("CB_MAIL_REMINDER"),
        ns.L("CB_MAIL_REMINDER_TIP"),
        cbEventReminder, 0, -10,
        function() return not S("disableMailReminder") end,
        function(v) SetS("disableMailReminder", not v) end)

    -- ── Section Dépendances (module dédié) ──────────────────────
    local depSection = ns.UI.BuildDependenciesSection(panel, cbMailReminder, PANEL_W)

    -- ── Séparateur horizontal avant les listes ─────────────────
    local sepMid = panel:CreateTexture(nil, "ARTWORK")
    sepMid:SetHeight(1)
    sepMid:SetPoint("TOPLEFT",  depSection.bottomAnchor, "BOTTOMLEFT", -2, -14)
    sepMid:SetPoint("TOPRIGHT", panel,                   "TOPRIGHT",   -8,   0)
    sepMid:SetColorTexture(C.accentDim[1], C.accentDim[2], C.accentDim[3], 0.40)

    -- ── Listes personnages / guildes (modules dédiés) ───────────
    local charList  = ns.UI.BuildCharacterList(panel, depSection.bottomAnchor, PANEL_W, COL_L_W, LIST_BOTTOM)
    local guildList = ns.UI.BuildGuildList(panel, depSection.bottomAnchor, PANEL_W, COL_R_X, LIST_BOTTOM)

    -- ── Redimensionnement du panneau ─────────────────────────────
    -- Les cadres perso/guilde suivent déjà les bords du panneau (ancres
    -- live), seules les lignes déjà peuplées doivent être redessinées
    -- à la bonne largeur une fois le geste terminé (pas à chaque frame :
    -- coûteux et inutile pendant le drag lui-même).
    ns.UI.MakeResizeGrip(panel, RESIZE_MIN_W, RESIZE_MIN_H, RESIZE_MAX_W, RESIZE_MAX_H,
        function()
            charList.Populate()
            guildList.Populate()
        end)

    -- Refresh à l'ouverture
    panel:SetScript("OnShow", function()
        local s = ViewerLogDB.settings or {}
        cbIcons:SetChecked(s.hideTooltipIcons    or false)
        cbGuild:SetChecked(s.hideGuildTooltip    or false)
        cbWarband:SetChecked(s.hideWarbandTooltip or false)
        cbRealm:SetChecked(s.hideRealmTooltip     or false)
        cbDisable:SetChecked(s.disableTooltip     or false)
        cbEventReminder:SetChecked(not s.disableEventReminder)
        cbMailReminder:SetChecked(not s.disableMailReminder)
        UpdateTooltipDependents()
        preview.Refresh()
        depSection.Refresh()
        charList.Populate()
        guildList.Populate()
    end)

    ns._optRefreshChars  = charList.Populate
    ns._optRefreshGuilds = guildList.Populate

    return panel
end

-- Points d'entrée publics, utilisés par ui/Minimap.lua, core/Init.lua
-- (slash command) et api/API.lua.
function ns.UI.ShowPanel()
    BuildPanel():Show()
end

function ns.UI.TogglePanel()
    local p = BuildPanel()
    if p:IsShown() then p:Hide() else p:Show() end
end
