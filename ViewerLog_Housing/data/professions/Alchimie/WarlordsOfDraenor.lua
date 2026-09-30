local addonName, pluginNs = ...

-- Alchimie — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Warlords of Draenor"] = {
    { name = "Chaudron orc gangresang", itemID = 257044, spellID = 1262011, decorID = 11379 },
    { name = "Tonneau de vin", itemID = 244318, spellID = 1260985, decorID = 1410 },
}
