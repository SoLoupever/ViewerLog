local addonName, pluginNs = ...

-- Travail du cuir — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Mists of Pandaria"] = {
    { name = "Lit de sage pandaren", itemID = 247767, spellID = 1261248, decorID = 3904 },
    { name = "Tente du pic de la Sérénité", itemID = 247856, spellID = 1261245, decorID = 3994 },
}
