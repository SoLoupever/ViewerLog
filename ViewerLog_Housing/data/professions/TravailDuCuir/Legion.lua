local addonName, pluginNs = ...

-- Travail du cuir — Legion — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Legion"] = {
    { name = "Clôture taurène en cuir", itemID = 245406, spellID = 1260762, decorID = 1242 },
    { name = "Piquet tauren", itemID = 245407, spellID = 1260765, decorID = 1243 },
    { name = "Cadre de tannerie de Haut-Roc", itemID = 257400, spellID = 1262273, decorID = 11490 },
}
