local addonName, pluginNs = ...

-- Alchimie — Battle for Azeroth — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Battle for Azeroth"] = {
    { name = "Lampe bouteille de Boralus", itemID = 257046, spellID = 1262005, decorID = 11381 },
    { name = "Cargaison de bouteilles zandalari", itemID = 257047, spellID = 1262151, decorID = 11382 },
}
