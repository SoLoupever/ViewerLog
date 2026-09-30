local addonName, pluginNs = ...

-- Joaillerie — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Dragon Isles"] = {
    { name = "Clôture de Valdrakken", itemID = 248109, spellID = 1259384, decorID = 4165 },
    { name = "Trône doré de Valdrakken", itemID = 248654, spellID = 1259369, decorID = 4480 },
    { name = "Piquet de Valdrakken", itemID = 248110, spellID = 1259386, decorID = 4166 },
}
