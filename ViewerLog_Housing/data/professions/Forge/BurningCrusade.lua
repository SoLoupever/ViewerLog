local addonName, pluginNs = ...

-- Forge — Burning Crusade — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Burning Crusade"] = {
    { itemID = 257036, spellID = 1261383, decorID = 11371 },
    { itemID = 257035, spellID = 1261347, decorID = 11370 },
    { itemID = 257039, spellID = 1261359, decorID = 11374 },
}
