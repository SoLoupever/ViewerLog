local addonName, ns = ...

-- Aperçu infobulle en temps réel. Ancré TOPRIGHT sous le coin bas-droit de `anchor`.

ns.UI = ns.UI or {}

function ns.UI.BuildTooltipPreview(parent, anchor, ax, ay, aw, ah)
    local frame = ns.UI.StyledFrame(parent, aw, ah, "preview")
    frame:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", ax, ay)

    local hdr = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hdr:SetPoint("TOPLEFT", 8, -6)
    ns.UI.Tint(hdr, "previewHdr")
    hdr:SetText(ns.L("TT_PREVIEW_HEADER"))

    local owned = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    owned:SetPoint("TOPLEFT", 8, -22)
    owned:SetText("|cffffff00" .. ns.L("TT_OWNED_BY") .. "|r")

    -- Personnage
    local charL = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    charL:SetPoint("TOPLEFT", 8, -36)
    local charR = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    charR:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -36)
    charR:SetText("|cffffff003|r " .. ns.L("TT_BAG"))

    -- Warband
    local wbL = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    wbL:SetPoint("TOPLEFT", 8, -52)
    local wbR = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    wbR:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -52)
    wbR:SetText("|cff0070dd2|r")

    -- Guilde
    local gL = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    gL:SetPoint("TOPLEFT", 8, -68)
    local gR = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    gR:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -68)
    gR:SetText("|cff0070dd5|r")

    -- Total
    local totL = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    totL:SetPoint("TOPLEFT", 8, -84)
    totL:SetText("|cffaaaaaa" .. ns.L("TT_TOTAL") .. "|r")
    local totR = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    totR:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -84)
    totR:SetText("|cffffffff10|r")

    frame.Refresh = function()
        local s = ViewerLogDB and ViewerLogDB.settings or {}

        local realmPart = ""
        if not s.hideRealmTooltip then
            realmPart = " |cff777777(" .. ns.L("PREVIEW_REALM_SAMPLE") .. ")|r"
        end

        -- Icônes
        if not s.hideTooltipIcons then
            charL:SetText("|cffaa44ff" .. ns.L("PREVIEW_CHAR_SAMPLE") .. "|r" .. realmPart)
            wbL:SetText("|T6124644:12:12:0:0|t |cffd4af37" .. ns.L("TT_WARBAND") .. "|r")
            gL:SetText("|TInterface\\Icons\\Achievement_GuildPerk_MobileBanking:12:12:0:0|t |cff40c0ff" .. ns.L("TT_GUILD") .. "|r")
        else
            charL:SetText("|cffaa44ff" .. ns.L("PREVIEW_CHAR_SAMPLE") .. "|r" .. realmPart)
            wbL:SetText("|cffd4af37" .. ns.L("TT_WARBAND") .. "|r")
            gL:SetText("|cff40c0ff" .. ns.L("TT_GUILD") .. " " .. ns.L("PREVIEW_GUILD_SAMPLE") .. "|r")
        end

        -- Warband
        if s.hideWarbandTooltip then wbL:Hide(); wbR:Hide() else wbL:Show(); wbR:Show() end
        -- Guilde
        if s.hideGuildTooltip   then gL:Hide();  gR:Hide()  else gL:Show();  gR:Show()  end
    end

    return frame
end
