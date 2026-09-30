local addonName, pluginNs = ...
local vlAPI = _G.ViewerLogAPI

-- API publique ViewerLog_Housing (lecture seule, sur _G.ViewerLogAPI).
-- Ce module ne dessine pas : AltViewerLog_Professions lit ces données pour
-- dessiner la barre housing (comme pour ViewerLog_Recette). Absent → la barre
-- est simplement masquée.

local function GetDefKey(profName)
    return (pluginNs.PROF_RECIPE_KEY and pluginNs.PROF_RECIPE_KEY[profName]) or profName
end

-- Retourne les données housing d'un personnage, par métier :
--   { [profName] = { defs = <RECIPE_DEFINITIONS[defKey]>,   -- table extension -> recettes
--                    known = { [itemID] = bool },           -- carte connu/non connu
--                    total = N, knownCount = K } }
-- defs est une référence en LECTURE SEULE (ne pas muter côté hôte).
local function GetHousingRecipes(charName, realmName)
    if not ViewerLogDB or not pluginNs.RECIPE_DEFINITIONS then return nil end
    if not charName or not realmName then return nil end
    local charData = ViewerLogDB[realmName] and ViewerLogDB[realmName][charName]
    if not charData or not charData.professions then return nil end

    -- Perso courant rafraîchi à la volée (recettes apprises).
    local isCurrent = (charName == UnitName("player") and realmName == GetRealmName())

    local out = nil
    for _, p in ipairs(charData.professions) do
        local defs = pluginNs.RECIPE_DEFINITIONS[GetDefKey(p.name)]
        if defs then
            if isCurrent and pluginNs.DetectKnownRecipes then
                pluginNs.DetectKnownRecipes(p)
            end
            local known = p.knownRecipes or {}
            local total, knownCount = 0, 0
            for _, recipes in pairs(defs) do
                for _, r in ipairs(recipes) do
                    total = total + 1
                    if known[r.itemID] then knownCount = knownCount + 1 end
                end
            end
            out = out or {}
            out[p.name] = { defs = defs, known = known, total = total, knownCount = knownCount }
        end
    end
    return out
end

pluginNs.GetHousingRecipes = GetHousingRecipes

-- ── Exposition sur l'API partagée ─────────────────────────────────
-- _G.ViewerLogAPI déjà chargé (RequiredDeps). Absentes si module non installé
-- (AltViewerLog_Professions teste leur présence).
if vlAPI then
    vlAPI.GetHousingRecipes      = GetHousingRecipes
    vlAPI.OpenHousingModelViewer = function(recipe, anchor)
        if pluginNs.OpenModelViewer then pluginNs.OpenModelViewer(recipe, anchor) end
    end
    vlAPI.HideHousingModelViewer = function()
        if pluginNs.HideModelViewer then pluginNs.HideModelViewer() end
    end
end
