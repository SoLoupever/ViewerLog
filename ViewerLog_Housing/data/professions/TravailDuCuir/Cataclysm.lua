local addonName, pluginNs = ...

-- Travail du cuir — Cataclysm — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Cataclysm"] = {
    { name = "Mosaïque du Crépuscule en écailles", itemID = 257806, spellID = 1269550, decorID = 11779 },
    { name = "Tapis scarabée roulé", itemID = 264677, spellID = 1272588, decorID = 16013 },
    { name = "Selle de rechange gilnéenne", itemID = 264712, spellID = 1272580, decorID = 16089 },
}
