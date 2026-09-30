local addonName, pluginNs = ...

-- Ingénierie — Legion — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Legion"] = {
    { itemID = 258225, spellID = 1263338, decorID = 11911 },
    { itemID = 258226, spellID = 1263319, decorID = 11912 },
}
