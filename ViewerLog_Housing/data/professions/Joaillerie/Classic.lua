local addonName, pluginNs = ...

-- Joaillerie — Classic — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Classic"] = {
    { name = "Réverbère rochenoire", itemID = 246413, spellID = 1261667, decorID = 2230 },
    { name = "Chandelier de Forgefer", itemID = 246488, spellID = 1261659, decorID = 2331 },
}
