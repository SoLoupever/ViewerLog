local addonName, pluginNs = ...

-- Joaillerie — Shadowlands — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"] = pluginNs.RECIPE_DEFINITIONS["Joaillerie"] or {}
pluginNs.RECIPE_DEFINITIONS["Joaillerie"]["Shadowlands"] = {
    { name = "Tablette runique maldraxxi", itemID = 260699, spellID = 1269504, decorID = 14380 },
    { name = "Lampe flottante kyriane", itemID = 262663, spellID = 1269502, decorID = 14676 },
}
