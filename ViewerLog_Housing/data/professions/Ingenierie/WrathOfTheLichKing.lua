local addonName, pluginNs = ...

-- Ingénierie — Wrath of the Lich King — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"] = pluginNs.RECIPE_DEFINITIONS["Ingénierie"] or {}
pluginNs.RECIPE_DEFINITIONS["Ingénierie"]["Wrath of the Lich King"] = {
    { itemID = 264707, spellID = 1272707, decorID = 16084 },
    { itemID = 264711, spellID = 1272676, decorID = 16088 },
    { itemID = 264708, spellID = 1272688, decorID = 16085 },
}
