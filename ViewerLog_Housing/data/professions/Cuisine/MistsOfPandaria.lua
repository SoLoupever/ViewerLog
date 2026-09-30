local addonName, pluginNs = ...

-- Cuisine — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"] = pluginNs.RECIPE_DEFINITIONS["Cuisine"] or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"]["Mists of Pandaria"] = {
    { name = "Pile de raviolis de mushan", itemID = 247220, spellID = 1266563, decorID = 2591 },
}
