local addonName, pluginNs = ...

-- Forge — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Battle for Azeroth"] = {
    { itemID = 252397, spellID = 1260691, decorID = 9046 },
    { itemID = 252399, spellID = 1260692, decorID = 9048 },
}
