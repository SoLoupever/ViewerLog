local addonName, pluginNs = ...

-- Ingénierie — Cataclysm — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Cataclysm"] = {
    { itemID = 245602, spellID = 1261258, decorID = 1793 },
    { itemID = 257689, spellID = 1262340, decorID = 11718 },
}
