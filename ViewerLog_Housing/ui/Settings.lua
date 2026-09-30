local addonName, pluginNs = ...

-- Section paramètres Housing, injectée dans le menu Paramètres d'AltViewerLog
-- (via core.RegisterSettingsSection). Option persistée dans ViewerLogDB.housing.

local _measureFS
local function TextWidth(text, fontObj)
    if not _measureFS then
        _measureFS = UIParent:CreateFontString(nil, "ARTWORK", fontObj or "GameFontHighlight")
    else
        _measureFS:SetFontObject(fontObj or "GameFontHighlight")
    end
    _measureFS:SetText(text)
    return math.ceil(_measureFS:GetStringWidth())
end

local function GetHousingStore()
    ViewerLogDB.housing = ViewerLogDB.housing or {}
    return ViewerLogDB.housing
end

function pluginNs.InjectHousingSettings(scrollChild, y)
    -- En-tête de section
    local secLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    secLabel:SetPoint("TOPLEFT", 20, y)
    secLabel:SetText("|cffcc88ffViewerLog_Housing|r")
    y = y - 26

    -- Option : Aperçu 2D des objets de housing
    local labelText2D = pluginNs.L("DISABLE_2D_PREVIEW")
    local rowW2D = 26 + 5 + TextWidth(labelText2D, "GameFontHighlight") + 16

    local row2D = CreateFrame("Frame", nil, scrollChild, "BackdropTemplate")
    row2D:SetSize(rowW2D, 28)
    row2D:SetPoint("TOPLEFT", 20, y)
    row2D:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8" })
    row2D:SetBackdropColor(0.10, 0.10, 0.10, 0.88)

    local cb2D = CreateFrame("CheckButton", nil, row2D, "InterfaceOptionsCheckButtonTemplate")
    cb2D:SetPoint("LEFT", row2D, "LEFT", 6, 0)
    cb2D:SetChecked(not (ViewerLogDB and ViewerLogDB.housing and ViewerLogDB.housing.disable2DPreview))
    cb2D.Text = cb2D:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    cb2D.Text:SetPoint("LEFT", cb2D, "RIGHT", 5, 0)
    cb2D.Text:SetText(labelText2D)
    cb2D:SetScript("OnClick", function(self)
        local store = GetHousingStore()
        store.disable2DPreview = not self:GetChecked()
    end)
    y = y - 32

    return y
end
