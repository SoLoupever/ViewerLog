local addonName, pluginNs = ...

-- Enchantement — Wrath of the Lich King — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Wrath of the Lich King"] = {
    { itemID = 257101, spellID = 1262825, decorID = 11439 },
    { itemID = 257094, spellID = 1262824, decorID = 11432 },
}
