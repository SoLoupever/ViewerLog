local addonName, pluginNs = ...

-- Calligraphie — Cataclysm — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Cataclysm"] = {
    { itemID = 245621, spellID = 1261259, decorID = 1830 },
    { itemID = 245622, spellID = 1261288, decorID = 1831 },
    { itemID = 245623, spellID = 1261278, decorID = 1832 },
    { itemID = 257695, spellID = 1269540, decorID = 11724 },
    { itemID = 257696, spellID = 1269534, decorID = 11725 },
}
