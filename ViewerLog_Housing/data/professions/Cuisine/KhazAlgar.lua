local addonName, pluginNs = ...

-- Cuisine — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"] = pluginNs.RECIPE_DEFINITIONS["Cuisine"] or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"]["Khaz Algar"] = {
    { name = "Plateau de fromages et mines de Dornic", itemID = 239170, spellID = 1245993, decorID = 759 },
    { name = "Pain de mine tranché de Dornic", itemID = 246708, spellID = 1245995, decorID = 2471 },
    { name = "Brique de bienvenue terrestre en forme de fromage", itemID = 246709, spellID = 1245994, decorID = 2472 },
    { name = "Assortiment de prédateur kaheti", itemID = 245326, spellID = 1266541, decorID = 765 },
}
