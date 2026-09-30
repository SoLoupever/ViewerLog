local addonName, pluginNs = ...

-- Calligraphie — Dragon Isles — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"] = pluginNs.RECIPE_DEFINITIONS["Calligraphie"] or {}
pluginNs.RECIPE_DEFINITIONS["Calligraphie"]["Dragon Isles"] = {
    { itemID = 248106, spellID = 1259441, decorID = 4162 },
    { itemID = 248107, spellID = 1259451, decorID = 4163 },
    { itemID = 264679, spellID = 1272572, decorID = 16015 },
    { itemID = 248108, spellID = 1259461, decorID = 4164 },
    { itemID = 248120, spellID = 1259429, decorID = 4176 },
    { itemID = 248119, spellID = 1259433, decorID = 4175 },
    { itemID = 248118, spellID = 1259422, decorID = 4174 },
}
