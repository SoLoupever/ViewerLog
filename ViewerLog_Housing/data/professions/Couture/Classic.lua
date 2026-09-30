local addonName, pluginNs = ...

-- Couture — Classic — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Classic"] = {
    { itemID = 246685, spellID = 1261695, decorID = 2452 },
    { itemID = 243336, spellID = 1261688, decorID = 1282 },
}
