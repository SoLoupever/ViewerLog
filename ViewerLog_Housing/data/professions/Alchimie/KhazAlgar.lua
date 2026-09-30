local addonName, pluginNs = ...

-- Alchimie — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Khaz Algar"] = {
    { name = "Bain de Sourceroc", itemID = 252758, spellID = 1259673, decorID = 9170 },
    { name = "Cornue d'alchimiste nérubienne", itemID = 257102, spellID = 1261878, decorID = 11440 },
}
