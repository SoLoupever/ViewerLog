local addonName, pluginNs = ...

-- Joaillerie — Wrath of the Lich King — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Wrath of the Lich King"] = {
    { name = "Chandelier solaire du Kirin Tor", itemID = 258208, spellID = 1263605, decorID = 11896 },
}
