local addonName, ns = ...

-- Réglage numérique de l'infobulle : limite de personnages affichés.
-- Stocké dans ViewerLogDB.settings (tooltipCharLimit), lu par
-- ViewerLog_Tooltip via GetSetting.

ns.UI = ns.UI or {}

local LIMIT_MIN, LIMIT_MAX = 1, 50
local ROW_H = 26

function ns.UI.BuildTooltipOptions(parent, anchor, width)
    local S, SetS = ns.UI.GetSetting, ns.UI.SetSetting

    local box = CreateFrame("Frame", nil, parent)
    box:SetSize(width, ROW_H)
    box:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -12)

    local label = box:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", box, "TOPLEFT", 0, -11)
    label:SetText(ns.L("TT_OPT_LIMIT"))
    ns.UI.Tint(label, "text")

    local limit = ns.UI.Stepper(box, LIMIT_MIN, LIMIT_MAX,
        function() return S("tooltipCharLimit") end,
        function(v) SetS("tooltipCharLimit", v) end,
        ns.L("TT_OPT_LIMIT_TIP"))
    limit:SetPoint("RIGHT", box, "TOPRIGHT", 0, -11)

    local api = {}

    function api.Update()
        limit.SetEnabled(not S("disableTooltip"))
    end

    function api.Refresh()
        limit.Refresh()
        api.Update()
    end

    return api
end
