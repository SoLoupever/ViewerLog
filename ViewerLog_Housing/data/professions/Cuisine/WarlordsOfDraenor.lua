local addonName, pluginNs = ...

-- Cuisine — Warlords of Draenor — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"] = pluginNs.RECIPE_DEFINITIONS["Cuisine"] or {}
pluginNs.RECIPE_DEFINITIONS["Cuisine"]["Warlords of Draenor"] = {
    { name = "Plat de personne affamée", itemID = 245428, spellID = 1266560, decorID = 749 },
}
