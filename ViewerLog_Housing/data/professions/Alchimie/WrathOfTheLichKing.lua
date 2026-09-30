local addonName, pluginNs = ...

-- Alchimie — Wrath of the Lich King — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Wrath of the Lich King"] = {
    { name = "Peste en boîte de la Couronne de glace", itemID = 258213, spellID = 1263559, decorID = 11901 },
    { name = "Bougeoir solaire de Dalaran", itemID = 264710, spellID = 1272614, decorID = 16087 },
    { name = "Orbe de sang san'lay", itemID = 258212, spellID = 1263558, decorID = 11900 },
}
