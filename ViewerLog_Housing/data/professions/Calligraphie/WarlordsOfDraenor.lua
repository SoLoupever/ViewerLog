local addonName, pluginNs = ...

-- Calligraphie — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Warlords of Draenor"] = {
    { itemID = 245441, spellID = 1269501, decorID = 1351 },
    { itemID = 245534, spellID = 1261032, decorID = 1725 },
    { itemID = 244313, spellID = 1269500, decorID = 1405 },
    { itemID = 244317, spellID = 1261066, decorID = 1409 },
    { itemID = 244319, spellID = 1261045, decorID = 1411 },
}
