local addonName, pluginNs = ...

-- Couture — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Mists of Pandaria"] = {
    { itemID = 247738, spellID = 1261250, decorID = 3878 },
    { itemID = 258302, spellID = 1263553, decorID = 11945 },
}
