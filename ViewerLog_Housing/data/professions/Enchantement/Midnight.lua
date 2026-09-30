local addonName, pluginNs = ...

-- Enchantement — Midnight — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"] = pluginNs.RECIPE_DEFINITIONS["Enchantement"] or {}
pluginNs.RECIPE_DEFINITIONS["Enchantement"]["Midnight"] = {
    { itemID = 262455, spellID = 1246905, decorID = 14585 },
    { itemID = 262450, spellID = 1246904, decorID = 14580 },
    { itemID = 268041, spellID = 1281349, decorID = 19234 },
    { itemID = 268039, spellID = 1281348, decorID = 19231 },
    { itemID = 262468, spellID = 1246903, decorID = 14598 },
    { itemID = 262590, spellID = 1246908, decorID = 14616 },
    { itemID = 246693, spellID = 1246909, decorID = 2460 },
    { itemID = 262470, spellID = 1246907, decorID = 14600 },
    { itemID = 268038, spellID = 1281342, decorID = 19229 },
    { itemID = 262458, spellID = 1246902, decorID = 14588 },
    { itemID = 262459, spellID = 1246906, decorID = 14589 },
    { itemID = 279335, spellID = 1296500, decorID = 26496 },
    { itemID = 279362, spellID = 1296499, decorID = 5129 },
    { itemID = 279332, spellID = 1296498, decorID = 26379 },
}
