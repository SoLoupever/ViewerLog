local addonName, pluginNs = ...

-- Ingénierie — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Khaz Algar"] = {
    { itemID = 253252, spellID = 1259778, decorID = 9268 },
    { itemID = 246066, spellID = 1259724, decorID = 1984 },
}
