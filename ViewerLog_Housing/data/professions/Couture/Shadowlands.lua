local addonName, pluginNs = ...

-- Couture — Shadowlands — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Shadowlands"] = {
    { itemID = 264713, spellID = 1272575, decorID = 16090 },
    { itemID = 258561, spellID = 1263853, decorID = 12165 },
    { itemID = 264678, spellID = 1272578, decorID = 16014 },
}
