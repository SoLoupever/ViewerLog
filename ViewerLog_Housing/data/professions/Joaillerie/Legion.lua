local addonName, pluginNs = ...

-- Joaillerie — Legion — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Legion"] = {
    { name = "Assortiment de joaillerie de Suramar", itemID = 258227, spellID = 1263351, decorID = 11913 },
    { name = "Fenêtre de Suramar ombragée", itemID = 245557, spellID = 1260757, decorID = 1746 },
}
