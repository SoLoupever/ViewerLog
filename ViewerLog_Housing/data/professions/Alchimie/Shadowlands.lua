local addonName, pluginNs = ...

-- Alchimie — Shadowlands — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Shadowlands"] = {
    { name = "Bougies en malsuif", itemID = 257051, spellID = 1261972, decorID = 11386 },
    { name = "Gland d'anima protégé par le voile", itemID = 257050, spellID = 1261958, decorID = 11385 },
}
