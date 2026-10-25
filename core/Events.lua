local addonName, ns = ...

-- Events : socle du noyau (identité du personnage).
-- Objets, état du personnage, or, réputation, métiers et coffre de guilde ont
-- leur propre event frame dans leur dépendance ; ils ne partagent que
-- _G.ViewerLogAPI.

local frame = CreateFrame("Frame", "ViewerLog_EventFrame")

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:RegisterEvent("PLAYER_LEAVING_WORLD")
frame:RegisterEvent("PLAYER_GUILD_UPDATE")
frame:RegisterEvent("GUILD_ROSTER_UPDATE")

frame:SetScript("OnEvent", function(self, event)

    if event == "PLAYER_LOGIN" then
        ViewerLogDB.settings = ViewerLogDB.settings or {}

    elseif event == "PLAYER_ENTERING_WORLD" then
        ns.ScanIdentity()
        C_Timer.After(8, ns.ScanGuildName)

    elseif event == "PLAYER_LEVEL_UP" then
        ns.ScanIdentity(true)

    elseif event == "PLAYER_LOGOUT"
        or event == "PLAYER_LEAVING_WORLD" then
        ns.ScanIdentity(true)
        ns.ScanGuildName()

    elseif event == "PLAYER_GUILD_UPDATE" then
        if not IsInGuild() then
            local charData = ns.GetCurrentCharData()
            if charData then charData.guild = nil end
        else
            ns.ScanGuildName()
        end

    elseif event == "GUILD_ROSTER_UPDATE" then
        ns.ScanGuildName()
    end
end)
