local addonName, pluginNs = ...

-- Joaillerie — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Battle for Azeroth"] = {
    { name = "Petit masque de Bwonsamdi, le Loa des tombes", itemID = 245496, spellID = 1260501, decorID = 1161 },
    { name = "Lampe-crâne embrasée zandalari", itemID = 245414, spellID = 1260492, decorID = 1200 },
}
