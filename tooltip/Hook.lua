local addonName, ns = ...

-- Infobulle : hook.
-- Intercepte les tooltips d'items et y ajoute les infos de possession
-- (index). Chaînes via ns.L, comportement piloté par ViewerLogDB.settings.

-- ── Icônes ───────────────────────────────────────────────────────

local ICON = {
    HORDE    = "|TInterface\\Icons\\PVPCurrency-Honor-Horde:14:14:0:0|t",
    ALLIANCE = "|TInterface\\Icons\\PVPCurrency-Honor-Alliance:14:14:0:0|t",
    WARBAND  = "|T6124644:14:14:0:0|t",
    GUILD    = "|TInterface\\Icons\\Achievement_GuildPerk_MobileBanking:14:14:0:0|t",
}

-- ── Cache couleurs de classe ──────────────────────────────────────

local classHex = {}
local function GetClassHex(class)
    if not classHex[class] then
        local c = (RAID_CLASS_COLORS and RAID_CLASS_COLORS[class])
               or { r = 0.8, g = 0.8, b = 0.8 }
        classHex[class] = string.format("FF%02x%02x%02x",
            math.floor(c.r * 255 + 0.5),
            math.floor(c.g * 255 + 0.5),
            math.floor(c.b * 255 + 0.5))
    end
    return classHex[class]
end

-- ── Injection dans l'infobulle ────────────────────────────────────

local function AppendInfo(tooltip, itemID)
    if not itemID then return end

    local s = ViewerLogDB.settings or {}
    if s.hideTooltip or s.disableTooltip         then return end
    if s.tooltipOnShift and not IsShiftKeyDown() then return end

    local entry = ns.GetTooltipEntry(itemID)
    if not entry then return end

    local showIcons  = not s.hideTooltipIcons
    local showGuild  = not s.hideGuildTooltip
    local showRealm  = not s.hideRealmTooltip

    local hasChars   = next(entry.chars)       ~= nil
    local hasWarband = (entry.warbandCount     or 0) > 0 and not s.hideWarbandTooltip
    local hasGuild   = (entry.guildCount       or 0) > 0 and showGuild
    if not hasChars and not hasWarband and not hasGuild then return end

    -- Total pré-calculé (affiché dans l'en-tête "Owned by").
    local preTotal = 0
    for _, ce in pairs(entry.chars) do
        preTotal = preTotal + (ce.bagCount or 0) + (ce.bankCount or 0)
    end
    if hasWarband then preTotal = preTotal + entry.warbandCount end
    if hasGuild   then preTotal = preTotal + entry.guildCount   end

    tooltip:AddLine(" ")
    tooltip:AddDoubleLine(
        ns.L("TT_OWNED_BY"),
        string.format("|cffb266ff%s :|r  |cffffffff%d|r", ns.L("TT_TOTAL"), preTotal),
        1, 0.80, 0, 1, 1, 1)

    local grandTotal = 0

    -- ── Personnages ───────────────────────────────────────────
    for _, ce in pairs(entry.chars) do
        local total = (ce.bagCount or 0) + (ce.bankCount or 0)
        if total > 0 then
            grandTotal = grandTotal + total
            local hex  = GetClassHex(ce.class or "WARRIOR")

            local factionIcon = ""
            if showIcons then
                if     ce.faction == "Horde"    then factionIcon = ICON.HORDE   .. " "
                elseif ce.faction == "Alliance" then factionIcon = ICON.ALLIANCE .. " "
                end
            end

            local left
            if showRealm then
                left = string.format("%s|c%s%s|r |c%s(%s)|r",
                    factionIcon, hex, ce.char, hex, ce.realm)
            else
                left = string.format("%s|c%s%s|r", factionIcon, hex, ce.char)
            end

            local parts = {}
            if (ce.bagCount  or 0) > 0 then
                parts[#parts+1] = string.format("|cffffffff%d :|r |cffa335ee%s|r", ce.bagCount,  ns.L("TT_BAG"))
            end
            if (ce.bankCount or 0) > 0 then
                parts[#parts+1] = string.format("|cffffffff%d :|r |cffa335ee%s|r", ce.bankCount, ns.L("TT_BANK"))
            end

            tooltip:AddDoubleLine(left, table.concat(parts, "  |cff444444·|r  "),
                1, 1, 1, 1, 1, 1)
        end
    end

    -- ── Bataillon ─────────────────────────────────────────────
    if hasWarband then
        grandTotal = grandTotal + entry.warbandCount
        local left  = (showIcons and ICON.WARBAND .. " " or "") ..
                      "|cffd4af37" .. ns.L("TT_WARBAND") .. "|r"
        local right = string.format("|cffffffff%d|r", entry.warbandCount)
        tooltip:AddDoubleLine(left, right, 1, 1, 1, 1, 1, 1)
    end

    -- ── Guildes ───────────────────────────────────────────────
    if hasGuild then
        grandTotal = grandTotal + entry.guildCount
        if entry.guilds then
            for gName, gCount in pairs(entry.guilds) do
                local left  = (showIcons and ICON.GUILD .. " " or "") ..
                              "|cff40c0ff" .. ns.L("TT_GUILD") .. " " .. gName .. "|r"
                local right = string.format("|cffffffff%d|r", gCount)
                tooltip:AddDoubleLine(left, right, 1, 1, 1, 1, 1, 1)
            end
        end
    end


end

-- ── Enregistrement du hook ────────────────────────────────────────
-- Enregistré une seule fois au chargement. Pour désactiver complètement
-- (et non juste masquer le contenu), on ne l'enregistre pas → /reload requis.

local disabled = ViewerLogDB and ViewerLogDB.settings and ViewerLogDB.settings.disableTooltip

if not disabled then
    if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item,
            function(tooltip, data)
                if data and data.id then AppendInfo(tooltip, data.id) end
            end)
    else
        -- Compatibilité versions antérieures.
        GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
            local _, link = tooltip:GetItem()
            if link then
                AppendInfo(tooltip, tonumber(link:match("item:(%d+)")))
            end
        end)
    end
end
