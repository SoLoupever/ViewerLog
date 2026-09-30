local addonName, pluginNs = ...

-- Calligraphie — Classic — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Classic"] = {
    { itemID = 246420, spellID = 1261587, decorID = 2237 },
    { itemID = 246423, spellID = 1261644, decorID = 2240 },
    { itemID = 258289, spellID = 1269495, decorID = 11935 },
    { itemID = 245502, spellID = 1261572, decorID = 854 },
    { itemID = 245503, spellID = 1261549, decorID = 922 },
}
