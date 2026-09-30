local addonName, pluginNs = ...

-- Forge — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Mists of Pandaria"] = {
    { itemID = 247752, spellID = 1261234, decorID = 3892 },
    { itemID = 247661, spellID = 1261235, decorID = 3831 },
}
