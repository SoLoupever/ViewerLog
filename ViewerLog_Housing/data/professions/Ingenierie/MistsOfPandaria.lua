local addonName, pluginNs = ...

-- Ingénierie — Mists of Pandaria — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Mists of Pandaria"] = {
    { itemID = 247733, spellID = 1261236, decorID = 3873 },
    { itemID = 258216, spellID = 1263551, decorID = 11904 },
}
