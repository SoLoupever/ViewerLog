local addonName, pluginNs = ...

-- Calligraphie — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Battle for Azeroth"] = {
    { itemID = 252389, spellID = 1260593, decorID = 9038 },
    { itemID = 245415, spellID = 1260564, decorID = 1313 },
    { itemID = 245416, spellID = 1260508, decorID = 1312 },
    { itemID = 252401, spellID = 1260596, decorID = 9050 },
    { itemID = 252035, spellID = 1260583, decorID = 8983 },
    { itemID = 245499, spellID = 1260577, decorID = 1217 },
}
