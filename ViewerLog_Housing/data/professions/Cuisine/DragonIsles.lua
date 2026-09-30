local addonName, pluginNs = ...

-- Cuisine — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"] = pluginNs.RECIPE_DEFINITIONS["Cuisine"] or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"]["Dragon Isles"] = {
    { name = "Côtes de bruffalon", itemID = 247225, spellID = 1260333, decorID = 2596 },
    { name = "Plat de brochettes de drake", itemID = 247222, spellID = 1266555, decorID = 2593 },
    { name = "Plat de fruits de fleurs de Valdrakken", itemID = 247224, spellID = 1260331, decorID = 2595 },
}
