local addonName, pluginNs = ...

-- Joaillerie — Burning Crusade — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Burning Crusade"] = {
    { name = "Table en verre du Kirin Tor", itemID = 258211, spellID = 1263577, decorID = 11899 },
    { name = "Chandelier en cristal draeneï", itemID = 262347, spellID = 1269496, decorID = 14553 },
    { name = "Bougeoir de Shattrath", itemID = 258200, spellID = 1263817, decorID = 11888 },
    { name = "Réverbère de Shattrath", itemID = 258201, spellID = 1263815, decorID = 11889 },
}
