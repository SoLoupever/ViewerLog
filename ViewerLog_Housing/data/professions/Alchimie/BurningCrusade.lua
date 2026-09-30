local addonName, pluginNs = ...

-- Alchimie — Burning Crusade — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Burning Crusade"] = {
    { name = "Flacon sin'dorei verni", itemID = 264705, spellID = 1272712, decorID = 16082 },
    { name = "Torche du Conseil des ombres", itemID = 264706, spellID = 1272723, decorID = 16083 },
    { name = "Sac d'étouffante", itemID = 264709, spellID = 1272715, decorID = 16086 },
}
