local addonName, pluginNs = ...

-- Alchimie — Legion — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Legion"] = {
    { name = "Fontaine sculptée de l'arcan'dor", itemID = 256680, spellID = 1262154, decorID = 11281 },
    { name = "Bassin de clairvoyance étoilé", itemID = 257045, spellID = 1262152, decorID = 11380 },
}
