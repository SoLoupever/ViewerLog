local addonName, pluginNs = ...

-- Alchimie — Classic — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Classic"] = {
    { name = "Établi d'apothicaire", itemID = 257100, spellID = 1262829, decorID = 11438 },
    { name = "Potion noire à bouchon", itemID = 257041, spellID = 1261495, decorID = 11376 },
}
