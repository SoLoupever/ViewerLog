local addonName, ns = ...

-- Bouton minimap (LibDBIcon) et points d'entrée vers le panneau de
-- paramètres : ns.OpenOptions et l'injection d'un bouton dans les
-- Settings de AltViewerLog.

ns.UI = ns.UI or {}

local minimapFrame = CreateFrame("Frame")
minimapFrame:RegisterEvent("PLAYER_LOGIN")
minimapFrame:SetScript("OnEvent", function(self)
    self:UnregisterAllEvents()

    ViewerLogDB.settings         = ViewerLogDB.settings or {}
    ViewerLogDB.settings.minimap = ViewerLogDB.settings.minimap or {}

    local ldbObj = {
        type  = "launcher",
        icon  = "Interface\\AddOns\\ViewerLog\\logo_vl.blp",
        OnClick = function(_, btn)
            if btn == "LeftButton" then
                ns.UI.TogglePanel()
            end
        end,
        OnTooltipShow = function(tt)
            tt:AddLine("|cff9955ffViewer|r|cffccaaffLog|r")
            tt:AddLine("|cff808080" .. ns.L("MINIMAP_TT_CLICK") .. "|r", 1, 1, 1)
        end,
    }

    local LibStub   = _G.LibStub
    local LibDBIcon = LibStub and LibStub("LibDBIcon-1.0", true)
    if LibDBIcon then
        LibDBIcon:Register("ViewerLog", ldbObj, ViewerLogDB.settings.minimap)
    end

    -- Remplace l'ouverture Blizzard
    ns.OpenOptions = ns.UI.ShowPanel

    -- ── Injection d'un bouton dans les Settings de AltViewerLog ──
    -- Via RegisterSettingsSection de BVL, sans modifier BVL.
    C_Timer.After(0.3, function()
        local avlAPI = _G.AltViewerLogAPI
        if not avlAPI or not avlAPI.RegisterSettingsSection then return end

        avlAPI.RegisterSettingsSection(function(sc, y)
            -- Titre de section
            local secLabel = sc:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            secLabel:SetPoint("TOPLEFT", 20, y)
            secLabel:SetText("|cffff66cc[ViewerLog]|r")
            y = y - 30

            -- Description
            local descLabel = sc:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            descLabel:SetPoint("TOPLEFT", 20, y)
            descLabel:SetText("|cffff66cc" .. (avlAPI.L and avlAPI.L("VL_SECTION_DESC") or ns.L("VL_SECTION_DESC")) .. "|r")
            y = y - 24

            -- Bouton "Ouvrir les paramètres ViewerLog"
            local btnW = 220
            local row = CreateFrame("Frame", nil, sc, "BackdropTemplate")
            row:SetSize(btnW + 20, 34)
            row:SetPoint("TOPLEFT", 20, y)
            row:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8" })
            row:SetBackdropColor(0.08, 0.04, 0.16, 0.92)

            local btn = CreateFrame("Button", nil, row, "BackdropTemplate")
            btn:SetSize(btnW, 26)
            btn:SetPoint("LEFT", row, "LEFT", 7, 0)
            btn:SetBackdrop({
                bgFile   = "Interface\\Buttons\\WHITE8x8",
                edgeFile = "Interface\\Buttons\\WHITE8x8",
                edgeSize = 1,
            })
            btn:SetBackdropColor(0.22, 0.08, 0.42, 1)

            -- Bordure alignée sur le thème actif de AltViewerLog. La section
            -- est reconstruite à chaque ouverture/changement de thème, donc
            -- lire avlAPI._themeBorder ici suffit (pas de hook).
            local function BorderColor()
                return avlAPI._themeBorder or { 0.55, 0.25, 0.90 }
            end
            local function Brighten(c)
                return math.min(1, c[1] + 0.20), math.min(1, c[2] + 0.20), math.min(1, c[3] + 0.20)
            end
            local c0 = BorderColor()
            btn:SetBackdropBorderColor(c0[1], c0[2], c0[3], 1)

            local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            lbl:SetPoint("CENTER")
            lbl:SetText("|cffff66cc" .. ns.L("VL_OPEN_SETTINGS_BTN") .. "|r")

            btn:SetScript("OnEnter", function(s)
                s:SetBackdropColor(0.34, 0.12, 0.60, 1)
                s:SetBackdropBorderColor(Brighten(BorderColor()))
            end)
            btn:SetScript("OnLeave", function(s)
                s:SetBackdropColor(0.22, 0.08, 0.42, 1)
                local c = BorderColor()
                s:SetBackdropBorderColor(c[1], c[2], c[3], 1)
            end)
            btn:SetScript("OnClick", function()
                ns.OpenOptions()
            end)

            y = y - 38
            return y
        end)
    end)
end)
