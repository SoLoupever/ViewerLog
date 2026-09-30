local addonName, pluginNs = ...

-- Couture — Wrath of the Lich King — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Wrath of the Lich King"] = {
    { itemID = 258298, spellID = 1263627, decorID = 11941 },
    { itemID = 258206, spellID = 1263620, decorID = 11894 },
}
