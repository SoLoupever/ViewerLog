local addonName, pluginNs = ...

local core  = _G.AltViewerLogAPI
local vlAPI = _G.ViewerLogAPI

-- ViewerLog_Housing greffe sur ViewerLog (données, ViewerLogDB) et fournit
-- sa section Paramètres + son aperçu 3D via AltViewerLog. Pas de vue propre :
-- la barre housing est dessinée par AltViewerLog_Professions, qui lit notre
-- API (_G.ViewerLogAPI.GetHousingRecipes), comme pour ViewerLog_Recette.
-- ViewerLog + AltViewerLog_Professions en RequiredDeps → ce module ne charge
-- pas si AltViewerLog est désactivé.
if not core then
    print("|cffff0000[VL-Housing]|r " .. (pluginNs.L and pluginNs.L("ERR_API_MISSING") or "AltViewerLogAPI introuvable."))
    return
end

if core.DBG then core.DBG("|cffcc88ff[VL-Housing]|r " .. pluginNs.L("DBG_LOADED")) end

-- ── Commandes slash ──────────────────────────────────────────────
SLASH_VLHOUSING1 = "/vlhousing"
SlashCmdList["VLHOUSING"] = function(msg)
    msg = msg and strtrim(msg:lower()) or ""
    if msg == "scan" then
        if pluginNs.DetectAllForCurrentChar then pluginNs.DetectAllForCurrentChar() end
        -- Rafraîchit la vue Métiers si ouverte (barre housing à jour).
        if core.RefreshActiveView then core.RefreshActiveView() end
    elseif msg == "debug" then
        if pluginNs.DebugHousingCategories then pluginNs.DebugHousingCategories() end
    else
        if core.DBG then core.DBG("|cffcc88ff[VL-Housing]|r " .. pluginNs.L("DBG_HELP")) end
    end
end

-- ── Section Settings (option aperçu 2D) ──────────────────────────
-- Injectée dans le panneau Paramètres d'AltViewerLog.
if core.RegisterSettingsSection then
    core.RegisterSettingsSection(function(scrollChild, y)
        if pluginNs.InjectHousingSettings then
            return pluginNs.InjectHousingSettings(scrollChild, y)
        end
        return y
    end)
end
