local addonName, pluginNs = ...

-- Forge — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Warlords of Draenor"] = {
    { itemID = 245600, spellID = 1260987, decorID = 1791 },
    { itemID = 245436, spellID = 1260988, decorID = 1325 },
}
