local addonName, pluginNs = ...

-- Forge — Legion — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Legion"] = {
    { itemID = 245408, spellID = 1260698, decorID = 1314 },
    { itemID = 247909, spellID = 1260695, decorID = 4023 },
    { itemID = 247922, spellID = 1260693, decorID = 4036 },
}
