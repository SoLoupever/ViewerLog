local addonName, pluginNs = ...

-- Couture — Burning Crusade — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Burning Crusade"] = {
    { itemID = 258202, spellID = 1263669, decorID = 11890 },
    { itemID = 258195, spellID = 1263692, decorID = 11883 },
}
