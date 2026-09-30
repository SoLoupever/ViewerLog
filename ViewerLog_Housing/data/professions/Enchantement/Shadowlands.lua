local addonName, pluginNs = ...

-- Enchantement — Shadowlands — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Shadowlands"] = {
    { itemID = 257098, spellID = 1261998, decorID = 11436 },
    { itemID = 258237, spellID = 1263238, decorID = 11918 },
}
