local addonName, pluginNs = ...

-- Enchantement — Legion — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Legion"] = {
    { itemID = 247923, spellID = 1260700, decorID = 4037 },
    { itemID = 256681, spellID = 1262238, decorID = 11282 },
}
