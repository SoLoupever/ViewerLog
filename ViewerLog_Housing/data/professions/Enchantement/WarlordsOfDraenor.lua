local addonName, pluginNs = ...

-- Enchantement — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Warlords of Draenor"] = {
    { itemID = 245601, spellID = 1260990, decorID = 1792 },
    { itemID = 251655, spellID = 1261008, decorID = 8787 },
}
