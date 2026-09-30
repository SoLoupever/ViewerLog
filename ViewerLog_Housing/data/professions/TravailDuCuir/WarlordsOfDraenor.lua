local addonName, pluginNs = ...

-- Travail du cuir — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] = pluginNs.RECIPE_DEFINITIONS["Travail du cuir"] or {}
pluginNs.RECIPE_DEFINITIONS["Travail du cuir"]["Warlords of Draenor"] = {
    { name = "Lit de camp orc", itemID = 244323, spellID = 1261122, decorID = 1415 },
    { name = "Lits superposés rochenoires", itemID = 245432, spellID = 1261081, decorID = 1321 },
}
