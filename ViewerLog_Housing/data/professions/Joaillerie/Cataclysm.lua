local addonName, pluginNs = ...

-- Joaillerie — Cataclysm — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Cataclysm"] = {
    { name = "Lampe à fumée", itemID = 257406, spellID = 1262357, decorID = 11496 },
    { name = "Bougeoir à fumée", itemID = 249143, spellID = 1261305, decorID = 5342 },
}
