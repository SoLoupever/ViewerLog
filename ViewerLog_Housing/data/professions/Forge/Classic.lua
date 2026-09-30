local addonName, pluginNs = ...

-- Forge — Classic — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Forge"] = pluginNs.RECIPE_DEFINITIONS["Forge"] or {}
pluginNs.RECIPE_DEFINITIONS["Forge"]["Classic"] = {
    { itemID = 246489, spellID = 1261499, decorID = 2332 },
    { itemID = 246111, spellID = 1261497, decorID = 2001 },
}
