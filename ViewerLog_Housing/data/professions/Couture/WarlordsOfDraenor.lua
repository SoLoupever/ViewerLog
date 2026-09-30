local addonName, pluginNs = ...

-- Couture — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Warlords of Draenor"] = {
    { itemID = 245421, spellID = 1261232, decorID = 929 },
    { itemID = 251546, spellID = 1261231, decorID = 8237 },
    { itemID = 258303, spellID = 1263360, decorID = 11946 },
}
