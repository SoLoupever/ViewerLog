local addonName, ns = ...

-- Scanner : index tooltip (lazy rebuild).
-- Les scanners marquent les sources invalidées ; le rebuild n'a lieu qu'au
-- moment où la tooltip le demande (GetTooltipEntry). O(1) par scan.
--
-- ns.tooltipIndex[itemID] = {
--   chars        = { ["Nom@Realm"] = { char, realm, class, faction, bagCount, bankCount, mailCount, auctionCount } },
--   warbandCount = N,
--   guildCount   = N,               -- total toutes guildes
--   guilds       = { [name] = N },  -- compte par guilde
-- }

ns.tooltipIndex = {}

-- ── Drapeaux d'invalidation ───────────────────────────────────────
-- Chaque source s'invalide indépendamment.
ns._indexPending = {
    chars   = false,   -- sacs / banque perso
    warband = false,   -- banque de bataillon
    guild   = false,   -- coffres de guilde
}

-- Invalide une ou plusieurs sources (appelé par les scanners).
function ns.InvalidateIndex(sources)
    if sources.chars   then ns._indexPending.chars   = true end
    if sources.warband then ns._indexPending.warband = true end
    if sources.guild   then ns._indexPending.guild   = true end
end

-- Invalide toutes les sources (migration, suppression…).
function ns.InvalidateIndexAll()
    ns._indexPending.chars   = true
    ns._indexPending.warband = true
    ns._indexPending.guild   = true
end

-- ── Rebuild partiel ───────────────────────────────────────────────

-- Entrée index d'un objet (créée au besoin).
local function GetEntry(idx, id)
    local entry = idx[id]
    if not entry then
        entry = { chars = {}, warbandCount = 0, guildCount = 0 }
        idx[id] = entry
    end
    return entry
end

-- Entrée perso d'un objet (créée au besoin).
local function GetCharEntry(idx, id, key, charName, realmName, data)
    local entry = GetEntry(idx, id)
    local ce = entry.chars[key]
    if not ce then
        ce = {
            char         = charName,
            realm        = realmName,
            class        = data.class,
            faction      = data.faction,
            bagCount     = 0,
            bankCount    = 0,
            mailCount    = 0,
            auctionCount = 0,
        }
        entry.chars[key] = ce
    end
    return ce
end

-- Indexe un conteneur (sacs ou banque) d'un perso.
local function IndexContainer(idx, slots, field, key, charName, realmName, data)
    if not slots then return end
    for _, slotData in pairs(slots) do
        if type(slotData) == "table" then
            for _, item in pairs(slotData) do
                local id    = type(item) == "table" and item.id    or item
                local count = type(item) == "table" and item.count or 1
                if id then
                    local ce = GetCharEntry(idx, id, key, charName, realmName, data)
                    ce[field] = ce[field] + count
                end
            end
        end
    end
end

-- Indexe le courrier (liste plate { { id, count }, ... }) d'un perso.
local function IndexMail(idx, mail, key, charName, realmName, data)
    if not mail then return end
    for _, item in ipairs(mail) do
        local id    = item.id
        local count = item.count or 1
        if id then
            local ce = GetCharEntry(idx, id, key, charName, realmName, data)
            ce.mailCount = ce.mailCount + count
        end
    end
end

-- Indexe les enchères ({ [itemID] = quantité }) d'un perso.
local function IndexAuctions(idx, auctions, key, charName, realmName, data)
    if not auctions then return end
    for id, count in pairs(auctions) do
        local ce = GetCharEntry(idx, id, key, charName, realmName, data)
        ce.auctionCount = ce.auctionCount + count
    end
end

local function RebuildChars(idx)
    -- Efface les entrées chars sans remplacer les tables (moins de GC).
    for _, entry in pairs(idx) do
        wipe(entry.chars)
    end

    for realmName, realmData in pairs(ViewerLogDB) do
        if ns.IsRealm(realmName, realmData) then
            for charName, data in pairs(realmData) do
                if type(data) == "table" then
                    local key = charName .. "@" .. realmName
                    IndexContainer(idx, data.bags, "bagCount",  key, charName, realmName, data)
                    IndexContainer(idx, data.bank, "bankCount", key, charName, realmName, data)
                    IndexMail(idx, data.mail, key, charName, realmName, data)
                    IndexAuctions(idx, data.auctions, key, charName, realmName, data)
                end
            end
        end
    end
end

local function RebuildWarband(idx)
    for _, entry in pairs(idx) do
        entry.warbandCount = 0
    end

    if ViewerLogDB.warbandBank then
        for _, slots in pairs(ViewerLogDB.warbandBank) do
            if type(slots) == "table" then
                for _, item in pairs(slots) do
                    local id    = type(item) == "table" and item.id    or item
                    local count = type(item) == "table" and item.count or 1
                    if id then
                        local entry = GetEntry(idx, id)
                        entry.warbandCount = entry.warbandCount + count
                    end
                end
            end
        end
    end
end

local function RebuildGuild(idx)
    for _, entry in pairs(idx) do
        entry.guildCount = 0
        if entry.guilds then wipe(entry.guilds) end
    end

    if ViewerLogDB.guilds then
        for _, gData in pairs(ViewerLogDB.guilds) do
            if type(gData) == "table" and gData.tabs then
                local gName = gData.guildName or "?"
                for _, tab in pairs(gData.tabs) do
                    if tab and tab.items then
                        for _, item in pairs(tab.items) do
                            if item and item.id then
                                local entry = GetEntry(idx, item.id)
                                entry.guildCount = entry.guildCount + (item.count or 1)
                                -- Compte par guilde (et non un total global répété par ligne).
                                entry.guilds = entry.guilds or {}
                                entry.guilds[gName] = (entry.guilds[gName] or 0) + (item.count or 1)
                            end
                        end
                    end
                end
            end
        end
    end
end

-- ── Nettoyage ──────────────────────────────────────────────────────
-- Retire les entrées devenues vides après un rebuild (borne la taille de l'index).
local function PruneEmptyEntries(idx)
    for id, entry in pairs(idx) do
        if next(entry.chars) == nil
            and (entry.warbandCount or 0) == 0
            and (entry.guildCount   or 0) == 0 then
            idx[id] = nil
        end
    end
end

-- ── Rebuild complet (migration, suppression, /vl scan) ────────────
function ns.BuildTooltipIndex()
    local idx = ns.tooltipIndex
    for k in pairs(idx) do idx[k] = nil end

    ns._indexPending.chars   = false
    ns._indexPending.warband = false
    ns._indexPending.guild   = false

    RebuildChars(idx)
    RebuildWarband(idx)
    RebuildGuild(idx)
    PruneEmptyEntries(idx)
end

-- ── Accès lazy (appelé par Hook.lua) ─────────────────────────────
-- Applique les rebuilds en attente puis retourne l'entrée. Coût nul si rien
-- n'a changé depuis le dernier appel.
function ns.GetTooltipEntry(itemID)
    local p = ns._indexPending
    if p.chars or p.warband or p.guild then
        local idx = ns.tooltipIndex
        if p.chars   then p.chars   = false; RebuildChars(idx)   end
        if p.warband then p.warband = false; RebuildWarband(idx)  end
        if p.guild   then p.guild   = false; RebuildGuild(idx)    end
        PruneEmptyEntries(idx)
    end
    return ns.tooltipIndex[itemID]
end
