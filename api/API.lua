local addonName, ns = ...

-- API publique (lecture seule), accessible via _G.ViewerLogAPI.
-- Les données ne se modifient que via les scanners.

-- ── Utilitaires ───────────────────────────────────────────────────

local function SplitKey(key)
    return key:match("^(.+)@(.+)$")
end

-- ── État général ──────────────────────────────────────────────────

function ns.IsReady()
    return ViewerLogDB ~= nil
end

function ns.OpenOptionsPanel()
    if ns.OpenOptions then ns.OpenOptions() end
end

-- ── Réglages ──────────────────────────────────────────────────────
-- Lecture seule de ViewerLogDB.settings, pour les dépendances qui n'ont
-- pas accès direct à ViewerLogDB (ex: flags "disableXxx" de ViewerLog_Reminder).
function ns.GetSetting(key)
    return ViewerLogDB.settings and ViewerLogDB.settings[key]
end

-- ── Stockage par module ───────────────────────────────────────────
-- Table persistante propre à un module (ViewerLogDB.modules[name]), créée
-- à la demande. Un module n'écrit que dans la sienne.
function ns.GetModuleData(name)
    if type(name) ~= "string" or name == "" then return nil end
    local mods = ViewerLogDB.modules
    if not mods then
        mods = {}
        ViewerLogDB.modules = mods
    end
    local data = mods[name]
    if not data then
        data = {}
        mods[name] = data
    end
    return data
end

-- ── Callbacks ─────────────────────────────────────────────────────
-- Notifie les modules sans les connaître. Événements : CHARACTER_DELETED(realm, char).
local listeners = {}

function ns.RegisterCallback(event, fn)
    if type(event) ~= "string" or type(fn) ~= "function" then return false end
    local list = listeners[event]
    if not list then
        list = {}
        listeners[event] = list
    end
    list[#list + 1] = fn
    return true
end

local function Fire(event, ...)
    local list = listeners[event]
    if not list then return end
    for i = 1, #list do
        local ok, err = pcall(list[i], ...)
        if not ok then geterrorhandler()(err) end
    end
end

-- ── Personnages ───────────────────────────────────────────────────

-- cb(charName, realmName, charData) pour chaque personnage connu.
function ns.ForEachCharacter(cb)
    for realmName, realmData in pairs(ViewerLogDB) do
        if ns.IsRealm(realmName, realmData) then
            for charName, charData in pairs(realmData) do
                if type(charData) == "table" then cb(charName, realmName, charData) end
            end
        end
    end
end

-- Liste des clés "Nom@Realm".
function ns.GetAllCharacters()
    local list = {}
    for realmName, realmData in pairs(ViewerLogDB) do
        if ns.IsRealm(realmName, realmData) then
            for charName, charData in pairs(realmData) do
                if type(charData) == "table" then
                    list[#list + 1] = charName .. "@" .. realmName
                end
            end
        end
    end
    return list
end

function ns.GetCharacterByKey(key)
    local charName, realmName = SplitKey(key)
    if not charName then return nil end
    return ViewerLogDB[realmName] and ViewerLogDB[realmName][charName]
end

function ns.GetCharacter(charName, realmName)
    return ViewerLogDB[realmName] and ViewerLogDB[realmName][charName]
end

-- Table du personnage, créée vide si inconnue. Pour la reprise de données
-- d'un autre addon (ex : ProfessionViewerLog) ; le scan normal passe par
-- GetCurrentCharData.
function ns.EnsureCharacter(charName, realmName)
    if not charName or not realmName then return nil end
    local realm = ViewerLogDB[realmName]
    if not realm then
        realm = {}
        ViewerLogDB[realmName] = realm
    end
    local data = realm[charName]
    if not data then
        data = {}
        realm[charName] = data
    end
    return data
end

-- ── Personnage courant ────────────────────────────────────────────

function ns.GetCurrentCharacterKey()
    local player = UnitName("player")
    local realm  = GetRealmName()
    if player and realm then
        return player .. "@" .. realm
    end
    return nil
end

-- ── Réputations ───────────────────────────────────────────────────
-- Format : { [factionID] = { name, reaction, standing, bottom, top,
--   isAccountWide, isMajor, renown, renownEarned, renownCap, maxRenown,
--   isUnlocked, paragonValue, paragonCap, paragonLevel, paragonReady,
--   updatedAt } }
function ns.GetReputations(charName, realmName)
    local d = ns.GetCharacter(charName, realmName)
    return d and d.reputations
end

-- ── Suppression ───────────────────────────────────────────────────

-- Supprime un perso et notifie les modules (CHARACTER_DELETED).
function ns.DeleteCharacter(realm, char)
    if not realm or not char then return false end
    if ViewerLogDB[realm] and ViewerLogDB[realm][char] then
        ViewerLogDB[realm][char] = nil
        if not next(ViewerLogDB[realm]) then
            ViewerLogDB[realm] = nil
        end
        Fire("CHARACTER_DELETED", realm, char)
        return true
    end
    return false
end

-- ── Table d'API publique ──────────────────────────────────────────
-- Peuple _G.ViewerLogAPI (créée vide par core/Init.lua). Seules ces
-- fonctions sont exposées ; le namespace interne (ns) reste privé.
-- GetCurrentCharData est exposée pour les dépendances (Items / Guild / Reput /
-- Professions), qui ont leur propre ns.
local pub = _G.ViewerLogAPI
pub.API_VERSION                 = ns.API_VERSION
pub.L                           = ns.L
pub.IsReady                     = ns.IsReady
pub.IsRealm                     = ns.IsRealm
pub.OpenOptionsPanel            = ns.OpenOptionsPanel
pub.GetAllCharacters            = ns.GetAllCharacters
pub.GetCharacterByKey           = ns.GetCharacterByKey
pub.GetCharacter                = ns.GetCharacter
pub.EnsureCharacter             = ns.EnsureCharacter
pub.ForEachCharacter            = ns.ForEachCharacter
pub.RegisterCallback            = ns.RegisterCallback
pub.GetCurrentCharData          = ns.GetCurrentCharData
pub.GetSetting                  = ns.GetSetting
pub.GetModuleData               = ns.GetModuleData
pub.DeleteCharacter             = ns.DeleteCharacter
pub.GetCurrentCharacterKey      = ns.GetCurrentCharacterKey
pub.GetReputations              = ns.GetReputations
-- Fonctions des modules (GetBags, GetGold, GetEstimatedRestedPct, GetAllGuilds,
-- ScanReputations, RegisterProfessionsCallback…) ne sont plus posées ici : chaque dépendance les ajoute elle-même sur cette table après
-- son chargement (garanti par RequiredDeps). Absentes si non installée.
