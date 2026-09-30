local addonName, pluginNs = ...

-- Calligraphie — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Mists of Pandaria"] = {
    { itemID = 247735, spellID = 1261240, decorID = 3875 },
    { itemID = 247731, spellID = 1261237, decorID = 3871 },
    { itemID = 247669, spellID = 1261241, decorID = 3839 },
    { itemID = 245514, spellID = 1261238, decorID = 1187 },
    { itemID = 245513, spellID = 1261239, decorID = 1169 },
}
