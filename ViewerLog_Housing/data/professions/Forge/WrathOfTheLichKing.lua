local addonName, pluginNs = ...

-- Forge — Wrath of the Lich King — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Wrath of the Lich King"] = {
    { itemID = 257040, spellID = 1261327, decorID = 11375 },
    { itemID = 264676, spellID = 1272662, decorID = 16012 },
}
