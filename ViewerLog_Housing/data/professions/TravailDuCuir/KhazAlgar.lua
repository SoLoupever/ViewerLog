local addonName, pluginNs = ...

-- Travail du cuir — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Khaz Algar"] = {
    { name = "Canapé éclairé de l’Incontinental", itemID = 239214, spellID = 1270836, decorID = 829 },
    { name = "Tapis à zhévrures", itemID = 243327, spellID = 1260328, decorID = 1273 },
}
