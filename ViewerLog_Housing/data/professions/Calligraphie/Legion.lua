local addonName, pluginNs = ...

-- Calligraphie — Legion — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Legion"] = {
    { itemID = 245396, spellID = 1260737, decorID = 1219 },
    { itemID = 258224, spellID = 1263344, decorID = 11910 },
    { itemID = 247916, spellID = 1260711, decorID = 4030 },
    { itemID = 247925, spellID = 1260730, decorID = 4039 },
    { itemID = 247918, spellID = 1260719, decorID = 4032 },
    { itemID = 245459, spellID = 1260704, decorID = 1308 },
}
