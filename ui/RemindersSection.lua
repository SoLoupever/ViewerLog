local addonName, ns = ...

-- Section Rappels de l'onglet Général. Réglages lus par ViewerLog_Reminder
-- via ViewerLogAPI.GetSetting (effet immédiat, pas de /reload).

ns.UI = ns.UI or {}

local BLOCK_H = 112

local OPTIONS = {
    { key = "disableEventReminder", label = "CB_EVENT_REMINDER" },
    { key = "disableMailReminder",  label = "CB_MAIL_REMINDER"  },
}

function ns.UI.BuildRemindersSection(page, prevBlock)
    local S, SetS = ns.UI.GetSetting, ns.UI.SetSetting

    local block = CreateFrame("Frame", nil, page)
    block:SetPoint("TOPLEFT",  prevBlock, "BOTTOMLEFT",  0, 0)
    block:SetPoint("TOPRIGHT", prevBlock, "BOTTOMRIGHT", 0, 0)
    block:SetHeight(BLOCK_H)

    ns.UI.HSep(block, -4, 10)
    local sec = ns.UI.SectionTitle(block, ns.L("SECTION_REMINDERS"), block, "TOPLEFT", 16, -18)

    local cbs, prev = {}, sec
    for i, o in ipairs(OPTIONS) do
        cbs[i] = ns.UI.Checkbox(block, ns.L(o.label), ns.L(o.label .. "_TIP"),
            prev, 0, (i == 1) and -12 or -10,
            function() return not S(o.key) end,
            function(v) SetS(o.key, not v) end)
        prev = cbs[i]
    end

    local function Refresh()
        for i, o in ipairs(OPTIONS) do cbs[i]:SetChecked(not S(o.key)) end
    end

    return { frame = block, Refresh = Refresh }
end
