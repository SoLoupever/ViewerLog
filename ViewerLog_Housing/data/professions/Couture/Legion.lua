local addonName, pluginNs = ...

-- Couture — Legion — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Legion"] = {
    { itemID = 247920, spellID = 1260774, decorID = 4034 },
    { itemID = 248010, spellID = 1260769, decorID = 4041 },
    { itemID = 258557, spellID = 1263858, decorID = 12161 },
}
