local addonName, pluginNs = ...

-- Enchantement — Cataclysm — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Cataclysm"] = {
    { itemID = 257095, spellID = 1262318, decorID = 11433 },
    { itemID = 257404, spellID = 1262331, decorID = 11494 },
}
