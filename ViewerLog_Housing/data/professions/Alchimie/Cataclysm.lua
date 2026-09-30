local addonName, pluginNs = ...

-- Alchimie — Cataclysm — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Cataclysm"] = {
    { name = "Chaudron gilnéen", itemID = 245517, spellID = 1261255, decorID = 855 },
    { name = "Potion verte gilnéenne", itemID = 257694, spellID = 1269506, decorID = 11723 },
}
