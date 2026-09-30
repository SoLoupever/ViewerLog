local addonName, pluginNs = ...

-- Ingénierie — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Battle for Azeroth"] = {
    { itemID = 246486, spellID = 1260352, decorID = 2329 },
    { itemID = 246604, spellID = 1260349, decorID = 2436 },
    { itemID = 246500, spellID = 1260425, decorID = 2340 },
}
