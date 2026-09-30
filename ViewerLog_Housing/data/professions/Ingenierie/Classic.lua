local addonName, pluginNs = ...

-- Ingénierie — Classic — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Classic"] = {
    { itemID = 246410, spellID = 1261509, decorID = 2227 },
    { itemID = 246700, spellID = 1261504, decorID = 2465 },
}
