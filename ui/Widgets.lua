local addonName, ns = ...

-- Widgets UI de base, réutilisés par les autres modules ui/*.
-- Aucune logique métier ici : uniquement des constructeurs de frames.

ns.UI = ns.UI or {}

ns.UI.Colors = {
    bg        = { 0.00, 0.00, 0.00, 0.97 },
    border    = { 0.45, 0.15, 0.70 },
    accent    = { 0.55, 0.25, 0.90 },
    accentDim = { 0.28, 0.10, 0.50 },
    rowSep    = { 0.20, 0.08, 0.35, 0.50 },
    delRed    = { 0.55, 0.08, 0.08 },
    delHov    = { 0.80, 0.15, 0.15 },
}
local C = ns.UI.Colors

function ns.UI.StyledFrame(parent, w, h)
    local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    f:SetSize(w, h)
    f:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    f:SetBackdropColor(C.bg[1], C.bg[2], C.bg[3], C.bg[4])
    f:SetBackdropBorderColor(C.border[1], C.border[2], C.border[3], 0.80)
    return f
end

function ns.UI.SectionTitle(parent, text, ax, ay)
    local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    fs:SetPoint("TOPLEFT", parent, "TOPLEFT", ax, ay)
    fs:SetText(text)
    fs:SetTextColor(C.accent[1] + 0.15, C.accent[2] + 0.15, C.accent[3] + 0.05)
    return fs
end

function ns.UI.HSep(parent, anchor, offY, x2offset)
    local t = parent:CreateTexture(nil, "ARTWORK")
    t:SetHeight(1)
    t:SetPoint("TOPLEFT",  anchor, "BOTTOMLEFT",  0, offY)
    t:SetPoint("TOPRIGHT", parent, "TOPRIGHT", x2offset or -8, 0)
    t:SetColorTexture(C.accentDim[1], C.accentDim[2], C.accentDim[3], 0.60)
    return t
end

function ns.UI.Checkbox(parent, label, tip, anchor, offX, offY, getter, setter)
    local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    cb:SetSize(22, 22)
    cb:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", offX, offY)
    cb:SetChecked(getter())
    local lbl = cb:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lbl:SetPoint("LEFT", cb, "RIGHT", 4, 0)
    lbl:SetText(label)
    cb.text = lbl
    if tip then
        cb:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
            GameTooltip:AddLine(tip, 1, 1, 0.7, true)
            GameTooltip:Show()
        end)
        cb:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end
    cb:SetScript("OnClick", function(s) setter(s:GetChecked()) end)
    return cb
end

-- Active/désactive visuellement une checkbox (utilisé quand
-- l'infobulle ViewerLog est entièrement coupée).
function ns.UI.SetCheckboxEnabled(cb, enabled)
    if enabled then
        cb:Enable()
        cb.text:SetTextColor(1, 1, 1)
    else
        cb:Disable()
        cb.text:SetTextColor(0.45, 0.45, 0.45)
    end
end

function ns.UI.DeleteBtn(parent, onClickFn)
    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetSize(76, 17)
    btn:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    btn:SetBackdropColor(0.05, 0.05, 0.05, 1)
    btn:SetBackdropBorderColor(C.delRed[1], C.delRed[2], C.delRed[3], 1)
    local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lbl:SetPoint("CENTER")
    lbl:SetText("|cffff4444" .. ns.L("DELETE_BTN") .. "|r")
    btn:SetScript("OnEnter", function(s)
        s:SetBackdropColor(0.15, 0.03, 0.03, 1)
        s:SetBackdropBorderColor(C.delHov[1], C.delHov[2], C.delHov[3], 1)
    end)
    btn:SetScript("OnLeave", function(s)
        s:SetBackdropColor(0.05, 0.05, 0.05, 1)
        s:SetBackdropBorderColor(C.delRed[1], C.delRed[2], C.delRed[3], 1)
    end)
    btn:SetScript("OnClick", onClickFn)
    return btn
end

function ns.UI.MakeScrollBox(parent, ax, ay, aw, ah)
    local bg = ns.UI.StyledFrame(parent, aw, ah)
    bg:SetPoint("TOPLEFT", parent, "TOPLEFT", ax, ay)
    local sf = CreateFrame("ScrollFrame", nil, bg, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT",     bg, "TOPLEFT",     4,  -4)
    sf:SetPoint("BOTTOMRIGHT", bg, "BOTTOMRIGHT", -22,  4)
    local child = CreateFrame("Frame", nil, sf)
    child:SetWidth(sf:GetWidth())
    child:SetHeight(1)
    sf:SetScrollChild(child)
    ns.UI.SkinScrollBar(sf)

    -- Le panneau de paramètres est redimensionnable (cf. ui/PanelResize.lua) :
    -- la largeur du contenu doit suivre celle de la ScrollFrame, sinon les
    -- lignes déjà peuplées restent calées sur l'ancienne largeur.
    sf:HookScript("OnSizeChanged", function()
        child:SetWidth(math.max(1, sf:GetWidth()))
    end)

    return bg, sf, child
end
