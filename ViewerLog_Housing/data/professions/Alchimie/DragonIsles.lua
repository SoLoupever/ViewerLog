local addonName, pluginNs = ...

-- Alchimie — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Dragon Isles"] = {
    { name = "Bouteille d'élixir de dragon", itemID = 257052, spellID = 1261882, decorID = 11387 },
    { name = "Vase verdoyant de Valdrakken", itemID = 248111, spellID = 1261885, decorID = 4167 },
}
