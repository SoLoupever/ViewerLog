local addonName, ns = ...

-- Bouton d'accès au Discord (sous l'aperçu infobulle) + sa popup.
--
-- StaticPopupDialogs avec hasEditBox=true ne fournit plus self.editBox
-- de façon fiable sur ce client (self.editBox nil à l'ouverture). Pas
-- d'API WoW pour ouvrir un lien dans le navigateur, donc "contrôlable"
-- = copiable : on construit notre propre petite frame avec un EditBox,
-- même mécanisme que le bouton Discord de MatchViewerLog (fenêtre
-- déplaçable, fermable via le bouton ou Échap, Ctrl+A/Ctrl+C natifs
-- sur l'EditBox).

ns.UI = ns.UI or {}

local DISCORD_URL = "https://discord.gg/2gfEKGAT46"

local dlg

local function EnsureDialog()
    if dlg then return dlg end
    local C = ns.UI.Colors

    dlg = CreateFrame("Frame", "VL_DiscordDialog", UIParent, "BackdropTemplate")
    dlg:SetSize(360, 112)
    dlg:SetPoint("CENTER")
    dlg:SetFrameStrata("DIALOG")
    dlg:SetToplevel(true)
    dlg:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 16,
        insets   = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    dlg:SetBackdropColor(0.05, 0.05, 0.07, 0.98)
    dlg:SetBackdropBorderColor(C.accent[1], C.accent[2], C.accent[3], 1)
    dlg:EnableMouse(true)
    dlg:SetMovable(true)
    dlg:RegisterForDrag("LeftButton")
    dlg:SetScript("OnDragStart", dlg.StartMoving)
    dlg:SetScript("OnDragStop", dlg.StopMovingOrSizing)
    tinsert(UISpecialFrames, "VL_DiscordDialog") -- fermable à l'Échap

    dlg.title = dlg:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    dlg.title:SetPoint("TOP", 0, -14)
    dlg.title:SetText(ns.L("DISCORD_BTN_LABEL"))

    local close = CreateFrame("Button", nil, dlg, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", 0, 0)

    dlg.hintFS = dlg:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    dlg.hintFS:SetPoint("TOP", 0, -38)
    dlg.hintFS:SetText(ns.L("DISCORD_HINT"))

    local box = CreateFrame("Frame", nil, dlg, "BackdropTemplate")
    box:SetPoint("TOPLEFT", 16, -58)
    box:SetPoint("TOPRIGHT", -16, -58)
    box:SetHeight(22)
    box:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    box:SetBackdropColor(0, 0, 0, 0.6)
    box:SetBackdropBorderColor(C.accent[1], C.accent[2], C.accent[3], 0.6)

    local edit = CreateFrame("EditBox", nil, box)
    edit:SetPoint("TOPLEFT", 6, 0)
    edit:SetPoint("BOTTOMRIGHT", -6, 0)
    edit:SetAutoFocus(false)
    edit:SetFontObject("ChatFontNormal")
    edit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    edit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    dlg.edit = edit

    return dlg
end

local function OpenDiscordDialog()
    EnsureDialog()
    dlg.edit:SetText(DISCORD_URL)
    dlg:Show()
    dlg:Raise()
    dlg.edit:SetFocus()
    dlg.edit:HighlightText()
end

function ns.UI.BuildDiscordButton(parent, anchorAbove, ax, ay, width)
    local C = ns.UI.Colors

    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetSize(width, 24)
    btn:SetPoint("TOPLEFT", anchorAbove, "BOTTOMLEFT", ax, ay)
    btn:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    btn:SetBackdropColor(0.05, 0.05, 0.05, 1)
    btn:SetBackdropBorderColor(C.accent[1], C.accent[2], C.accent[3], 1)

    local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lbl:SetPoint("CENTER")
    lbl:SetText("|cffcc99ff" .. ns.L("DISCORD_BTN_LABEL") .. "|r")
    btn.text = lbl

    btn:SetScript("OnEnter", function(s)
        s:SetBackdropColor(0.15, 0.08, 0.20, 1)
        s:SetBackdropBorderColor(C.accent[1] + 0.2, C.accent[2] + 0.2, C.accent[3] + 0.05, 1)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        GameTooltip:AddLine(ns.L("DISCORD_BTN_TIP"), 1, 1, 0.7, true)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function(s)
        s:SetBackdropColor(0.05, 0.05, 0.05, 1)
        s:SetBackdropBorderColor(C.accent[1], C.accent[2], C.accent[3], 1)
        GameTooltip:Hide()
    end)
    btn:SetScript("OnClick", OpenDiscordDialog)

    return btn
end
