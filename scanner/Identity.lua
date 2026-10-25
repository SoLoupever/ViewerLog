local addonName, ns = ...

-- Identité du personnage : niveau, classe, faction, guilde, dernière connexion.
-- Socle du noyau, indépendant de tout scanner d'objets.

local select = select
local time   = time

-- skipLastLogin : true hors connexion (logout, level up).
function ns.ScanIdentity(skipLastLogin)
    local charData = ns.GetCurrentCharData()
    if not charData then return end

    local level = UnitLevel("player")
    if level and level > 0 then charData.level = level end

    local class = select(2, UnitClass("player"))
    if class then charData.class = class end

    local faction = UnitFactionGroup("player")
    if faction then charData.faction = faction end

    if not skipLastLogin then charData.lastLogin = time() end
end

-- Nom de guilde (nil si sans guilde). GetGuildInfo peut être vide au login :
-- rappelé sur les événements de guilde.
function ns.ScanGuildName()
    local charData = ns.GetCurrentCharData()
    if not charData then return end

    local guildName = GetGuildInfo("player")
    if guildName then
        charData.guild = (guildName ~= "") and guildName or nil
    end
end
