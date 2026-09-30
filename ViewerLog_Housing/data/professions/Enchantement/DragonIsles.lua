local addonName, pluginNs = ...

-- Enchantement — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Dragon Isles"] = {
    { itemID = 256171, spellID = 1261919, decorID = 10965 },
    { itemID = 256170, spellID = 1261933, decorID = 10964 },
}
