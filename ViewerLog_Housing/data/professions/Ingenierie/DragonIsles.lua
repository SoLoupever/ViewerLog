local addonName, pluginNs = ...

-- Ingénierie — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Dragon Isles"] = {
    { itemID = 248113, spellID = 1259404, decorID = 4169 },
    { itemID = 258253, spellID = 1263237, decorID = 11929 },
}
