local addonName, pluginNs = ...

-- Forge — Shadowlands — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Shadowlands"] = {
    { itemID = 257049, spellID = 1261980, decorID = 11384 },
    { itemID = 257048, spellID = 1261982, decorID = 11383 },
}
