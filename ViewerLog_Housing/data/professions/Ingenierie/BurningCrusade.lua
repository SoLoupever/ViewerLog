local addonName, pluginNs = ...

-- Ingénierie — Burning Crusade — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Burning Crusade"] = {
    { itemID = 258194, spellID = 1263643, decorID = 11882 },
    { itemID = 258193, spellID = 1263654, decorID = 11881 },
    { itemID = 258196, spellID = 1263663, decorID = 11884 },
}
