local addonName, pluginNs = ...

-- Ingénierie — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Warlords of Draenor"] = {
    { itemID = 244314, spellID = 1261027, decorID = 1406 },
    { itemID = 251482, spellID = 1261025, decorID = 8191 },
}
