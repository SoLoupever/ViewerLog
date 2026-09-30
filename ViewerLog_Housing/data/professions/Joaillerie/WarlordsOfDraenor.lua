local addonName, pluginNs = ...

-- Joaillerie — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Warlords of Draenor"] = {
    { name = "Bougeoir en draenéthyste", itemID = 251550, spellID = 1261075, decorID = 8241 },
    { name = "Bassin draénique", itemID = 251495, spellID = 1261071, decorID = 8196 },
}
