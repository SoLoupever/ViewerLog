local addonName, pluginNs = ...

-- Calligraphie — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Khaz Algar"] = {
    { itemID = 253165, spellID = 1260044, decorID = 9239 },
    { itemID = 253164, spellID = 1260005, decorID = 9238 },
    { itemID = 253022, spellID = 1259796, decorID = 9180 },
    { itemID = 253167, spellID = 1259784, decorID = 9241 },
    { itemID = 253036, spellID = 1259818, decorID = 9184 },
    { itemID = 253169, spellID = 1259805, decorID = 9243 },
}
