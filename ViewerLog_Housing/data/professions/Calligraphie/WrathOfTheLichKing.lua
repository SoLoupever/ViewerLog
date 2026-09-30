local addonName, pluginNs = ...

-- Calligraphie — Wrath of the Lich King — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Wrath of the Lich King"] = {
    { itemID = 258209, spellID = 1263574, decorID = 11897 },
    { itemID = 258204, spellID = 1263575, decorID = 11892 },
    { itemID = 258207, spellID = 1263570, decorID = 11895 },
    { itemID = 258210, spellID = 1263564, decorID = 11898 },
    { itemID = 258203, spellID = 1263562, decorID = 11891 },
}
