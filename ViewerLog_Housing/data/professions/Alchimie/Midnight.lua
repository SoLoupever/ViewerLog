local addonName, pluginNs = ...

-- Alchimie — Midnight — définitions de recettes housing.
-- Champs : name (repli d'affichage), itemID, spellID (IsPlayerSpell), decorID (optionnel).

pluginNs.RECIPE_DEFINITIONS = pluginNs.RECIPE_DEFINITIONS or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"] = pluginNs.RECIPE_DEFINITIONS["Alchimie"] or {}
pluginNs.RECIPE_DEFINITIONS["Alchimie"]["Midnight"] = {
    { name = "Fontaine en flèche de Lune-d’Argent", itemID = 257420, spellID = 1233138, decorID = 11501 },
    { name = "Source entropique", itemID = 262355, spellID = 1233132, decorID = 14558 },
    { name = "Conservateurs haranir,", itemID = 262356, spellID = 1233137, decorID = 14559 },
    { name = "Cuve racinaire", itemID = 253506, spellID = 1233133, decorID = 1247 },
    { name = "Pierre de faille", itemID = 262354, spellID = 1233136, decorID = 14557 },
    { name = "Encensoir fume-soleil", itemID = 256356, spellID = 1233135, decorID = 11138 },
    { name = "Fausse giclée de venin", itemID = 279359, spellID = 1296429, decorID = 26391 },
}
