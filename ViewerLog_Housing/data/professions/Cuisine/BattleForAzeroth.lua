local addonName, pluginNs = ...

-- Cuisine — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"] = pluginNs.RECIPE_DEFINITIONS["Cuisine"] or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"]["Battle for Azeroth"] = {
    { name = "Plat de homard à la mode de Boralus", itemID = 245484, spellID = 1260337, decorID = 755 },
}
