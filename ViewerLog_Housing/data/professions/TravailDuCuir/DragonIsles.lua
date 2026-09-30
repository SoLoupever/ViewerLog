local addonName, pluginNs = ...

-- Travail du cuir — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Dragon Isles"] = {
    { name = "Lit gigone draconique", itemID = 248114, spellID = 1259195, decorID = 4170 },
    { name = "Tonnelle pliante de Valdrakken", itemID = 248657, spellID = 1259233, decorID = 4483 },
}
