local addonName, pluginNs = ...

-- Enchantement — Burning Crusade — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Burning Crusade"] = {
    { itemID = 257038, spellID = 1261340, decorID = 11373 },
    { itemID = 257037, spellID = 1261331, decorID = 11372 },
    { itemID = 257093, spellID = 1262828, decorID = 11431 },
}
