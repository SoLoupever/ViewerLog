local addonName, pluginNs = ...

-- Enchantement — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Battle for Azeroth"] = {
    { itemID = 258559, spellID = 1263870, decorID = 12163 },
    { itemID = 258560, spellID = 1263877, decorID = 12164 },
}
