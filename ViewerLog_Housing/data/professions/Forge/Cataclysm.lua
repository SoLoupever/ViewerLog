local addonName, pluginNs = ...

-- Forge — Cataclysm — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Cataclysm"] = {
    { itemID = 257042, spellID = 1261256, decorID = 11377 },
    { itemID = 257409, spellID = 1262308, decorID = 11497 },
}
