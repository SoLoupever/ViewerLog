local addonName, pluginNs = ...

-- Forge — Midnight — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Midnight"] = {
    { itemID = 262460, spellID = 1276111, decorID = 14590 },
    { itemID = 262456, spellID = 1276109, decorID = 14586 },
    { itemID = 262452, spellID = 1276112, decorID = 14582 },
    { itemID = 262457, spellID = 1276110, decorID = 14587 },
    { itemID = 262451, spellID = 1276108, decorID = 14581 },
    { itemID = 275305, spellID = 1296496, decorID = 26381 },
    { itemID = 279329, spellID = 1296497, decorID = 26382 },
    { itemID = 263709, spellID = 1296495, decorID = 15266 },
}