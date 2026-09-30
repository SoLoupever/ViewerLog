local addonName, pluginNs = ...

-- Travail du cuir — Wrath of the Lich King — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Wrath of the Lich King"] = {
    { name = "Sac postal varleu", itemID = 258205, spellID = 1263613, decorID = 11893 },
    { name = "Épouvantotem de la tribu Tombeneige", itemID = 257693, spellID = 1269499, decorID = 11722 },
}
