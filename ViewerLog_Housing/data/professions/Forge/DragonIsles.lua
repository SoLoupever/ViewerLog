local addonName, pluginNs = ...

-- Forge — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Dragon Isles"] = {
    { itemID = 256430, spellID = 1261892, decorID = 11165 },
    { itemID = 256427, spellID = 1261896, decorID = 11162 },
}
