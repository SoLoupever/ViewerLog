local addonName, pluginNs = ...

-- Constantes ViewerLog_Housing (données statiques) :
--   couleurs / liste d'extensions, mapping métier → clé RECIPE_DEFINITIONS,
--   traduction FR/EN des noms de métier.

pluginNs.TIER_COLORS = {
    -- Anglais
    ["Midnight"]               = { r = 0.55, g = 0.35, b = 1.00 },
    ["Khaz Algar"]             = { r = 0.40, g = 0.85, b = 1.00 },
    ["The War Within"]         = { r = 0.40, g = 0.85, b = 1.00 },
    ["Dragon Isles"]           = { r = 0.20, g = 0.90, b = 0.50 },
    ["Dragonflight"]           = { r = 0.20, g = 0.90, b = 0.50 },
    ["Shadowlands"]            = { r = 0.70, g = 0.50, b = 1.00 },
    ["Battle for Azeroth"]     = { r = 0.20, g = 0.60, b = 1.00 },
    ["Legion"]                 = { r = 0.90, g = 0.50, b = 1.00 },
    ["Warlords of Draenor"]    = { r = 1.00, g = 0.65, b = 0.20 },
    ["Mists of Pandaria"]      = { r = 0.20, g = 0.80, b = 0.30 },
    ["Cataclysm"]              = { r = 1.00, g = 0.30, b = 0.10 },
    ["Wrath of the Lich King"] = { r = 0.60, g = 0.80, b = 1.00 },
    ["Burning Crusade"]        = { r = 1.00, g = 0.55, b = 0.10 },
    ["Classic"]                = { r = 0.85, g = 0.75, b = 0.55 },
    ["Global"]                 = { r = 0.60, g = 0.60, b = 0.60 },
    -- Francais
    ["Minuit"]                 = { r = 0.55, g = 0.35, b = 1.00 },
    ["les dragons"]            = { r = 0.20, g = 0.90, b = 0.50 },
    ["l'Ombre"]                = { r = 0.70, g = 0.50, b = 1.00 },
    ["Terres de"]              = { r = 0.70, g = 0.50, b = 1.00 },
    ["Azeroth"]                = { r = 0.20, g = 0.60, b = 1.00 },
    ["Draenor"]                = { r = 1.00, g = 0.65, b = 0.20 },
    ["Pandaria"]               = { r = 0.20, g = 0.80, b = 0.30 },
    ["Cataclysme"]             = { r = 1.00, g = 0.30, b = 0.10 },
    ["Lich King"]              = { r = 0.60, g = 0.80, b = 1.00 },
    ["Roi-Liche"]              = { r = 0.60, g = 0.80, b = 1.00 },
    ["Croisade"]               = { r = 1.00, g = 0.55, b = 0.10 },
    ["Classique"]              = { r = 0.85, g = 0.75, b = 0.55 },
    ["classique"]              = { r = 0.85, g = 0.75, b = 0.55 },
}

pluginNs.EXPANSION_LIST = {
    { name = "Midnight",              defaultMax = 100, aliases = { "Minuit" } },
    { name = "Khaz Algar",            defaultMax = 100, aliases = { "Khaz Algar" } },
    { name = "Dragon Isles",          defaultMax = 100, aliases = { "les dragons", "Île-aux-Dragons", "Île aux Dragons" } },
    { name = "Shadowlands",           defaultMax = 115, aliases = { "l'Ombre", "Outre-Tombe" } },
    { name = "Battle for Azeroth",    defaultMax = 175, aliases = { "Bataille pour Azeroth" } },
    { name = "Legion",                defaultMax = 100, aliases = { "Légion" } },
    { name = "Warlords of Draenor",   defaultMax = 100, aliases = { "Seigneurs de Draenor", "Draenor" } },
    { name = "Mists of Pandaria",     defaultMax = 75,  aliases = { "Brumes de Pandarie", "Pandarie" } },
    { name = "Cataclysm",             defaultMax = 75,  aliases = { "Cataclysme" } },
    { name = "Wrath of the Lich King",defaultMax = 75,  aliases = { "Roi-Liche", "Colère du Roi-Liche" } },
    { name = "Burning Crusade",       defaultMax = 75,  aliases = { "Croisade ardente" } },
    { name = "Classic",               defaultMax = 300, aliases = { "Classique" } },
}

function pluginNs.GetTierColor(name)
    if not name then return { r = 0.5, g = 0.5, b = 0.5 } end
    for key, color in pairs(pluginNs.TIER_COLORS) do
        if name:find(key, 1, true) then return color end
    end
    return { r = 0.5, g = 0.7, b = 1.0 }
end

-- Mapping nom métier → clé RECIPE_DEFINITIONS (clés FR même en client EN).
pluginNs.PROF_RECIPE_KEY = {
    ["Alchimie"]        = "Alchimie",
    ["Alchemy"]         = "Alchimie",
    ["Travail du cuir"] = "Travail du cuir",
    ["Leatherworking"]  = "Travail du cuir",
    ["Cuisine"]         = "Cuisine",
    ["Cooking"]         = "Cuisine",
    ["Joaillerie"]      = "Joaillerie",
    ["Jewelcrafting"]   = "Joaillerie",
    ["Forge"]           = "Forge",
    ["Blacksmithing"]   = "Forge",
    ["Enchantement"]    = "Enchantement",
    ["Enchanting"]      = "Enchantement",
    ["Ingénierie"]      = "Ingénierie",
    ["Engineering"]     = "Ingénierie",
    ["Calligraphie"]    = "Calligraphie",
    ["Inscription"]     = "Calligraphie",
    ["Couture"]         = "Couture",
    ["Tailoring"]       = "Couture",
}

-- Traduction des noms de métier (affichage de la vue Housing).
pluginNs.PROF_EN_NAME = {
    ["Alchimie"]        = "Alchemy",
    ["Forge"]           = "Blacksmithing",
    ["Travail du cuir"] = "Leatherworking",
    ["Couture"]         = "Tailoring",
    ["Ingénierie"]      = "Engineering",
    ["Enchantement"]    = "Enchanting",
    ["Joaillerie"]      = "Jewelcrafting",
    ["Calligraphie"]    = "Inscription",
    ["Cuisine"]         = "Cooking",
}

pluginNs.PROF_FR_NAME = {
    ["Alchemy"]         = "Alchimie",
    ["Blacksmithing"]   = "Forge",
    ["Leatherworking"]  = "Travail du cuir",
    ["Tailoring"]       = "Couture",
    ["Engineering"]     = "Ingénierie",
    ["Enchanting"]      = "Enchantement",
    ["Jewelcrafting"]   = "Joaillerie",
    ["Inscription"]     = "Calligraphie",
    ["Cooking"]         = "Cuisine",
}
