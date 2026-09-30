local addonName, pluginNs = ...

-- Calligraphie — Burning Crusade — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Burning Crusade"] = {
    { itemID = 258198, spellID = 1263811, decorID = 11886 },
    { itemID = 258197, spellID = 1263813, decorID = 11885 },
    { itemID = 258215, spellID = 1263812, decorID = 11903 },
    { itemID = 258192, spellID = 1263814, decorID = 11880 },
    { itemID = 258199, spellID = 1263810, decorID = 11887 },
}
