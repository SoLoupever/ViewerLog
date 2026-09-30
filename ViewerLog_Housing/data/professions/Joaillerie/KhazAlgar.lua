local addonName, pluginNs = ...

-- Joaillerie — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Khaz Algar"] = {
    { name = "Fenêtre ocre octogonale", itemID = 245559, spellID = 1260096, decorID = 1748 },
    { name = "Candélabre de Gundargaz", itemID = 253253, spellID = 1260172, decorID = 9269 },
}
