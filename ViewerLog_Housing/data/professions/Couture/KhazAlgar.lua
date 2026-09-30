local addonName, pluginNs = ...

-- Couture — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Khaz Algar"] = {
    { itemID = 245305, spellID = 1260326, decorID = 1275 },
    { itemID = 252755, spellID = 1260215, decorID = 9167 },
}
