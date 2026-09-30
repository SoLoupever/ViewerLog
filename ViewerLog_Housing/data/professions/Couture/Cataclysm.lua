local addonName, pluginNs = ...

-- Couture — Cataclysm — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Cataclysm"] = {
    { itemID = 257402, spellID = 1262370, decorID = 11492 },
    { itemID = 245618, spellID = 1261317, decorID = 1827 },
}
