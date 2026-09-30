local addonName, ns = ...

-- Liste des guildes scannées (colonne droite du panneau),
-- avec suppression individuelle.

ns.UI = ns.UI or {}

local ROW_H = 22

function ns.UI.BuildGuildList(panel, anchorAbove, panelWidth, colX, bottomMargin)
    local C = ns.UI.Colors

    local secGuilds = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    secGuilds:SetPoint("TOPLEFT", anchorAbove, "BOTTOMLEFT", colX - 8, -22)
    secGuilds:SetText(ns.L("SECTION_GUILDS"))
    secGuilds:SetTextColor(C.accent[1] + 0.15, C.accent[2] + 0.15, C.accent[3] + 0.05)
    ns.UI.HSep(panel, secGuilds, -2)

    local colWidth = panelWidth - colX - 12
    local guildBg, _, guildChild = ns.UI.MakeScrollBox(panel, 8, -20, colWidth, 330)
    guildBg:ClearAllPoints()
    guildBg:SetPoint("TOPLEFT",     secGuilds, "BOTTOMLEFT", -2, -6)
    guildBg:SetPoint("BOTTOMRIGHT", panel,     "BOTTOMRIGHT", -12, bottomMargin)

    local function PopulateGuilds()
        for _, c in ipairs({guildChild:GetChildren()}) do c:Hide() end

        local rows = {}
        if ViewerLogDB.guilds then
            for key, gData in pairs(ViewerLogDB.guilds) do
                if type(gData) == "table" then
                    rows[#rows + 1] = { key = key, data = gData }
                end
            end
        end
        table.sort(rows, function(a, b)
            return (a.data.guildName or "") < (b.data.guildName or "")
        end)

        local yOff = 0
        for _, row in ipairs(rows) do
            local key, gData = row.key, row.data

            local r = CreateFrame("Frame", nil, guildChild)
            r:SetSize(guildChild:GetWidth() - 4, ROW_H)
            r:SetPoint("TOPLEFT", 0, yOff)

            local nm = r:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            nm:SetPoint("LEFT", 4, 0)
            nm:SetText(string.format("|cffffff88%s|r |cff555555(%s)|r",
                gData.guildName or "?", gData.realm or "?"))

            local capKey, capGuildName = key, gData.guildName
            local del = ns.UI.DeleteBtn(r, function()
                StaticPopup_Show("VL_DEL_GUILD",
                    capGuildName or capKey, nil, { key = capKey })
            end)
            del:SetPoint("RIGHT", -2, 0)

            local sep = r:CreateTexture(nil, "BACKGROUND")
            sep:SetHeight(1)
            sep:SetPoint("BOTTOMLEFT",  r, "BOTTOMLEFT",  0, 0)
            sep:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", 0, 0)
            sep:SetColorTexture(0.25, 0.15, 0.08, 0.45)

            yOff = yOff - ROW_H
        end
        guildChild:SetHeight(math.max(1, -yOff))

        if #rows == 0 then
            local e = guildChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            e:SetPoint("TOPLEFT", 4, -4)
            e:SetTextColor(0.4, 0.4, 0.4)
            e:SetText(ns.L("NO_GUILD_SCANNED"))
            guildChild:SetHeight(30)
        end
    end

    return { Populate = PopulateGuilds }
end
