local addonName, ns = ...

-- Liste des personnages enregistrés (colonne gauche du panneau),
-- avec suppression individuelle.

ns.UI = ns.UI or {}

local ROW_H = 22

function ns.UI.BuildCharacterList(panel, anchorAbove, panelWidth, colWidth, bottomMargin)
    local C = ns.UI.Colors

    local secChars = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    secChars:SetPoint("TOPLEFT", anchorAbove, "BOTTOMLEFT", 0, -22)
    secChars:SetText(ns.L("SECTION_CHARACTERS"))
    secChars:SetTextColor(C.accent[1] + 0.15, C.accent[2] + 0.15, C.accent[3] + 0.05)
    ns.UI.HSep(panel, secChars, -2, -(panelWidth - colWidth + 4))

    local charBg, _, charChild = ns.UI.MakeScrollBox(panel, 8, -20, colWidth - 4, 330)
    charBg:ClearAllPoints()
    charBg:SetPoint("TOPLEFT",     secChars, "BOTTOMLEFT", -2, -6)
    charBg:SetPoint("BOTTOMRIGHT", panel,    "BOTTOMLEFT", colWidth + 4, bottomMargin)

    local function PopulateChars()
        for _, c in ipairs({charChild:GetChildren()}) do c:Hide() end

        local rows = {}
        for realmName, realmData in pairs(ViewerLogDB) do
            if ns.IsRealm(realmName, realmData) then
                for charName, data in pairs(realmData) do
                    if type(data) == "table" then
                        rows[#rows + 1] = { realm = realmName, char = charName, data = data }
                    end
                end
            end
        end
        table.sort(rows, function(a, b)
            if a.realm ~= b.realm then return a.realm < b.realm end
            return a.char < b.char
        end)

        local yOff = 0
        for _, row in ipairs(rows) do
            local charName, realmName, data = row.char, row.realm, row.data

            local r = CreateFrame("Frame", nil, charChild)
            r:SetSize(charChild:GetWidth() - 4, ROW_H)
            r:SetPoint("TOPLEFT", 0, yOff)

            -- Icône faction
            local fx = r:CreateTexture(nil, "OVERLAY")
            fx:SetSize(14, 14)
            fx:SetPoint("LEFT", 2, 0)
            fx:SetTexture(data.faction == "Horde"
                and "Interface\\Icons\\PVPCurrency-Honor-Horde"
                or  "Interface\\Icons\\PVPCurrency-Honor-Alliance")

            -- Couleur de classe (colorStr = ex: "ff00f0ff" pour DEATHKNIGHT)
            local classKey = data.class and string.upper(data.class) or ""
            local col = (RAID_CLASS_COLORS and RAID_CLASS_COLORS[classKey])
            local colorStr
            if col and col.colorStr then
                colorStr = col.colorStr
            elseif col then
                colorStr = string.format("ff%02x%02x%02x",
                    math.floor((col.r or 0.8) * 255),
                    math.floor((col.g or 0.8) * 255),
                    math.floor((col.b or 0.8) * 255))
            else
                colorStr = "ffcccccc"
            end

            local nm = r:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            nm:SetPoint("LEFT",  r, "LEFT",  20,  0)
            nm:SetPoint("RIGHT", r, "RIGHT", -82, 0)
            nm:SetJustifyH("LEFT")
            nm:SetText(string.format("|c%s[%s]|r |c%s%s|r  |c%sLv%d|r",
                colorStr, realmName, colorStr, charName, colorStr, data.level or 0))

            -- Bouton ✕
            local capChar, capRealm = charName, realmName
            local del = ns.UI.DeleteBtn(r, function()
                StaticPopup_Show("VL_DEL_CHAR",
                    capChar .. " (" .. capRealm .. ")", nil,
                    { char = capChar, realm = capRealm })
            end)
            del:SetPoint("RIGHT", -2, 0)

            -- Séparateur
            local sep = r:CreateTexture(nil, "BACKGROUND")
            sep:SetHeight(1)
            sep:SetPoint("BOTTOMLEFT",  r, "BOTTOMLEFT",  0, 0)
            sep:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", 0, 0)
            sep:SetColorTexture(C.rowSep[1], C.rowSep[2], C.rowSep[3], C.rowSep[4])

            yOff = yOff - ROW_H
        end
        charChild:SetHeight(math.max(1, -yOff))

        if #rows == 0 then
            local e = charChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            e:SetPoint("TOPLEFT", 4, -4)
            e:SetTextColor(0.4, 0.4, 0.4)
            e:SetText(ns.L("NO_CHAR_REGISTERED"))
            charChild:SetHeight(30)
        end
    end

    return { Populate = PopulateChars }
end
