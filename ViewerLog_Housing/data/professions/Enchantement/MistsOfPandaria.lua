local addonName, pluginNs = ...

-- Enchantement — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Mists of Pandaria"] = {
    { itemID = 257096, spellID = 1262306, decorID = 11434 },
    { itemID = 257097, spellID = 1262302, decorID = 11435 },
}
