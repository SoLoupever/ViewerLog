local addonName, pluginNs = ...

-- Enchantement — Classic — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Classic"] = {
    { itemID = 263027, spellID = 1270459, decorID = 14816 },
    { itemID = 253250, spellID = 1261501, decorID = 9266 },
}
