local addonName, pluginNs = ...

-- Joaillerie — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Mists of Pandaria"] = {
    { name = "Mur pandaren en pierre", itemID = 245509, spellID = 1261243, decorID = 1194 },
    { name = "Fontaine draconique du temple de Jade", itemID = 247736, spellID = 1261242, decorID = 3876 },
    { name = "Poteau pandaren en pierre", itemID = 247728, spellID = 1261244, decorID = 3868 },
}
