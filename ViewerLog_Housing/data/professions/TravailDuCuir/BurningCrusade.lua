local addonName, pluginNs = ...

-- Travail du cuir — Burning Crusade — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Burning Crusade"] = {
    { name = "Épouvantail leurre arakkoa", itemID = 258191, spellID = 1263818, decorID = 11879 },
    { name = "Bannière mag’har de l’Outreterre", itemID = 258190, spellID = 1263819, decorID = 11878 },
}
