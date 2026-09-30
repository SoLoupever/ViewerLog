local addonName, pluginNs = ...

-- Alchimie — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Mists of Pandaria"] = {
    { name = "Kit d'alchimiste pandaren", itemID = 258214, spellID = 1263548, decorID = 11902 },
    { name = "Cornue d'alchimiste pandarène", itemID = 257043, spellID = 1261233, decorID = 11378 },
}
