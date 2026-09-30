local addonName, pluginNs = ...

-- Couture — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Dragon Isles"] = {
    { itemID = 257053, spellID = 1261940, decorID = 11388 },
    { itemID = 248121, spellID = 1259247, decorID = 4177 },
}
