local addonName, ns = ...

-- Wood tracker unifié (côté ViewerLog). Source de données : ViewerLogDB, déjà
-- scanné par le cœur ViewerLog (banque de bataillon + sacs du perso courant).
-- Aucun scan propre ici → pas de double scan. Exposé via _G.ViewerLogAPI pour
-- les consommateurs (AltViewerLog_Professions, etc.).

-- Liste canonique des bois par extension (ordre = ancien → récent).
ns.WOOD_BY_EXPANSION = {
    { expansion = "Classic",                color = { 0.85, 0.75, 0.55 }, items = {{ id = 245586, name = "Bois de bois-de-fer" }}},
    { expansion = "Burning Crusade",        color = { 1.00, 0.55, 0.10 }, items = {{ id = 242691, name = "Bois d'olemba" }}},
    { expansion = "Wrath of the Lich King", color = { 0.60, 0.80, 1.00 }, items = {{ id = 251762, name = "Bois de Vent-froid" }}},
    { expansion = "Cataclysme",             color = { 1.00, 0.30, 0.10 }, items = {{ id = 251764, name = "Bois de frêne" }}},
    { expansion = "Pandarie",               color = { 0.20, 0.80, 0.30 }, items = {{ id = 251763, name = "Bois de bambou" }}},
    { expansion = "Draenor",                color = { 1.00, 0.65, 0.20 }, items = {{ id = 251766, name = "Bois d'Ombrelune" }}},
    { expansion = "Legion",                 color = { 0.90, 0.50, 1.00 }, items = {{ id = 251767, name = "Bois touché par la corruption" }}},
    { expansion = "Battle for Azeroth",     color = { 0.20, 0.60, 1.00 }, items = {{ id = 251768, name = "Bois de sombrepin" }}},
    { expansion = "Shadowlands",            color = { 0.70, 0.50, 1.00 }, items = {{ id = 251772, name = "Bois d'Arden" }}},
    { expansion = "Dragonflight",           color = { 0.20, 0.90, 0.50 }, items = {{ id = 251773, name = "Bois de pin-des-dragons" }}},
    { expansion = "Khaz Algar",             color = { 0.40, 0.85, 1.00 }, items = {{ id = 248012, name = "Bois d'épicéa de Dornic" }}},
    { expansion = "Midnight",               color = { 0.55, 0.35, 1.00 }, items = {{ id = 256963, name = "Bois thalasséen" }}},
}

-- Lookup plat id → nom (set O(1) pour les scans).
ns.WOOD_ITEM_IDS = {}
for _, expBlock in ipairs(ns.WOOD_BY_EXPANSION) do
    for _, item in ipairs(expBlock.items) do
        ns.WOOD_ITEM_IDS[item.id] = item.name
    end
end

-- Nom localisé (nom WoW si l'objet est en cache, sinon repli FR intégré).
function ns.GetWoodItemName(id)
    local n = GetItemInfo and GetItemInfo(id)
    if n then return n end
    return ns.WOOD_ITEM_IDS[id] or "?"
end

-- Somme banque de bataillon + sacs du perso courant, lue depuis ViewerLogDB.
-- Retourne total + detail (id → quantité).
function ns.GetWoodCounts()
    local total, detail = 0, {}
    local woodSet = ns.WOOD_ITEM_IDS
    local db = _G.ViewerLogDB
    if not db then return total, detail end

    local function accumulate(container)
        for _, bagData in pairs(container) do
            if type(bagData) == "table" then
                for _, slot in pairs(bagData) do
                    if slot and slot.id and woodSet[slot.id] then
                        local q = slot.count or 1
                        total = total + q
                        detail[slot.id] = (detail[slot.id] or 0) + q
                    end
                end
            end
        end
    end

    -- Banque de bataillon (partagée, account-wide).
    if type(db.warbandBank) == "table" then accumulate(db.warbandBank) end

    -- Sacs du perso courant.
    local realm  = GetRealmName()
    local player = UnitName("player")
    local charBags = realm and player
        and db[realm] and db[realm][player] and db[realm][player].bags
    if type(charBags) == "table" then accumulate(charBags) end

    return total, detail
end

-- Exposition sur l'API partagée (créée par le cœur ViewerLog ; RequiredDeps
-- garantit que _G.ViewerLogAPI existe déjà ici).
if _G.ViewerLogAPI then
    _G.ViewerLogAPI.GetWoodCounts     = ns.GetWoodCounts
    _G.ViewerLogAPI.GetWoodExpansions = function() return ns.WOOD_BY_EXPANSION end
    _G.ViewerLogAPI.GetWoodItemName   = ns.GetWoodItemName
end
