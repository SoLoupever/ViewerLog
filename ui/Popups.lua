local addonName, ns = ...

-- Popups de confirmation utilisées par le panneau de paramètres.
-- Enregistrées dans StaticPopupDialogs (registre Blizzard existant) :
-- appelées par leur clé depuis n'importe quel module ui/*, sans
-- dépendance directe à ce fichier.

StaticPopupDialogs["VL_RELOAD_UI"] = {
    text     = ns.L("POPUP_RELOAD_TEXT"),
    button1  = ns.L("POPUP_RELOAD_BTN1"),
    button2  = ns.L("POPUP_RELOAD_BTN2"),
    OnAccept = function() ReloadUI() end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["VL_DEL_CHAR"] = {
    text     = ns.L("POPUP_DEL_CHAR_TEXT"),
    button1  = ns.L("DELETE_BTN"),
    button2  = ns.L("CANCEL_BTN"),
    OnAccept = function(_, data)
        if not data then return end
        ns.DeleteCharacter(data.realm, data.char)
        if ns._optRefreshChars then ns._optRefreshChars() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["VL_DEL_GUILD"] = {
    text     = ns.L("POPUP_DEL_GUILD_TEXT"),
    button1  = ns.L("DELETE_BTN"),
    button2  = ns.L("CANCEL_BTN"),
    OnAccept = function(_, data)
        if not data then return end
        local del = _G.ViewerLogAPI.DeleteGuildData
        if del then del(data.key) end
        if ns._optRefreshGuilds then ns._optRefreshGuilds() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}
