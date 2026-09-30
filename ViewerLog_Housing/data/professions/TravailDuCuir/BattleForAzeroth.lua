local addonName, pluginNs = ...

-- Travail du cuir — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Battle for Azeroth"] = {
    { name = "Tambour rituel zandalari", itemID = 245412, spellID = 1260485, decorID = 1241 },
    { name = "Bannière de diplomate furie-des-sables", itemID = 258558, spellID = 1263859, decorID = 12162 },
}
