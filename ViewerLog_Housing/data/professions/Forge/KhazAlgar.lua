local addonName, pluginNs = ...

-- Forge — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Khaz Algar"] = {
    { itemID = 245323, spellID = 1259681, decorID = 1270 },
    { itemID = 245312, spellID = 1259675, decorID = 1260 },
}
