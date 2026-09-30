local addonName, pluginNs = ...

-- Couture — Midnight — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Couture"] = pluginNs.RECIPE_DEFINITIONS["Couture"] or {}
pluginNs.RECIPE_DEFINITIONS["Couture"]["Midnight"] = {
    { itemID = 262592, spellID = 1229003, decorID = 14618 },
    { itemID = 262591, spellID = 1229002, decorID = 14617 },
    { itemID = 262599, spellID = 1229000, decorID = 14624 },
    { itemID = 262352, spellID = 1229001, decorID = 14555 },
    { itemID = 262593, spellID = 1246919, decorID = 14619 },
    { itemID = 262611, spellID = 1246929, decorID = 14636 },
    { itemID = 279350, spellID = 1296512, decorID = 26495 },
    { itemID = 279353, spellID = 1296514, decorID = 26366 },
}
