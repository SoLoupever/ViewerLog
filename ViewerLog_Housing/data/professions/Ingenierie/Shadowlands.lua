local addonName, pluginNs = ...

-- Ingénierie — Shadowlands — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Shadowlands"] = {
    { itemID = 258240, spellID = 1263239, decorID = 11921 },
    { itemID = 258252, spellID = 1263240, decorID = 11928 },
}
