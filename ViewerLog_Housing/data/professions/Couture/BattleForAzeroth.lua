local addonName, pluginNs = ...

-- Couture — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Battle for Azeroth"] = {
    { itemID = 245418, spellID = 1260475, decorID = 1311 },
    { itemID = 243101, spellID = 1260458, decorID = 1168 },
}
