local addonName, pluginNs = ...

-- Travail du cuir — Shadowlands — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Shadowlands"] = {
    { name = "Caisse maldraxxi", itemID = 258238, spellID = 1263313, decorID = 11919 },
    { name = "Tapis de margrave raccommodé en cuir", itemID = 258248, spellID = 1263308, decorID = 11926 },
}
