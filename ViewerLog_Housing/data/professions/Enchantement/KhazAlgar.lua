local addonName, pluginNs = ...

-- Enchantement — Khaz Algar — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Khaz Algar"] = {
    { itemID = 253171, spellID = 1259690, decorID = 9245 },
    { itemID = 253039, spellID = 1259715, decorID = 9187 },
}
