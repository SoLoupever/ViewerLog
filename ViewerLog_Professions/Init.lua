local addonName, ns = ...

-- Init ViewerLog_Professions : dépendance optionnelle de ViewerLog.
-- Scan de base des métiers (nom, icône, rang courant ; PAS le scan
-- approfondi des recettes, qui reste dans AltViewerLog_Professions).
-- ns et event frame propres ; partage ViewerLogDB.

local frame = CreateFrame("Frame", "ViewerLog_Professions_EventFrame")

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("SKILL_LINES_CHANGED")

frame:SetScript("OnEvent", function(self, event, ...)

    -- PLAYER_LOGIN : GetProfessions() est fiable seulement ~8 s après
    -- login (délai géré en interne par ns.OnProfessionsLogin).
    if event == "PLAYER_LOGIN" then
        if ns.OnProfessionsLogin then ns.OnProfessionsLogin() end

    -- SKILL_LINES_CHANGED : gain de rang ou changement de métier.
    -- Dispatché à Professions.lua qui gère son propre debounce (3 s).
    elseif event == "SKILL_LINES_CHANGED" then
        if ns.OnSkillLinesChanged then ns.OnSkillLinesChanged() end
    end
end)

-- ── Exposition sur l'API partagée ───────────────────────────────
-- RegisterProfessionsCallback : consommée par AltViewerLog.
-- ScanBasicProfessions : consommée par /vl scan (core).
if _G.ViewerLogAPI then
    _G.ViewerLogAPI.RegisterProfessionsCallback = ns.RegisterProfessionsCallback
    _G.ViewerLogAPI.ScanBasicProfessions        = ns.ScanBasicProfessions
end
