local addonName, ns = ...

-- ── English ──────────────────────────────────────────
ns.locales["enUS"] = {
    -- ── Item tooltip (ViewerLog_Tooltip addon) ──────────────────
    TT_OWNED_BY = "Owned by",
    TT_BAG      = "Bag",
    TT_BANK     = "Bank",
    TT_MAIL     = "Mail",
    TT_WARBAND  = "Warband",
    TT_GUILD    = "Guild",
    TT_TOTAL    = "Total",

    -- ── /vl slash commands ───────────────────────────────────────
    SLASH_SCAN_DONE          = "Inventory scan complete.",
    SLASH_REPUT_SCAN_DONE    = "Reputation scan complete.",
    SLASH_REPUT_NONE         = "ViewerLog_Reput dependency not installed.",
    SLASH_GUILD_SCAN_STARTED = "Guild bank scan started.",
    SLASH_GUILD_SCAN_DONE    = "Guild bank scan complete.",
    SLASH_GUILD_NONE_OPEN    = "No guild bank open.",
    SLASH_HELP_OPTIONS       = "  /vl |cffffff00options|r   — settings",
    SLASH_HELP_SCAN          = "  /vl |cffffff00scan|r      — inventory scan",
    SLASH_HELP_REPUT         = "  /vl |cffffff00reput|r     — reputation scan",
    SLASH_HELP_GUILD         = "  /vl |cffffff00guild|r     — guild bank scan",

    -- ── Settings panel (ui/*.lua) ────────────────────────────────
    DELETE_BTN          = "Delete",
    CANCEL_BTN          = "Cancel",

    TT_PREVIEW_HEADER   = "Tooltip preview",
    PREVIEW_CHAR_SAMPLE  = "YourChar",
    PREVIEW_REALM_SAMPLE = "Realm",
    PREVIEW_GUILD_SAMPLE = "GuildName",

    DISCORD_BTN_LABEL   = "Discord",
    DISCORD_BTN_TIP     = "Join the ViewerLog Discord server",
    DISCORD_HINT        = "Select all (Ctrl+A) then copy (Ctrl+C).",

    SECTION_TOOLTIPS    = "  Tooltips",
    CB_HIDE_ICONS        = "Remove tooltip icons",
    CB_HIDE_ICONS_TIP    = "Removes the icons (faction, warband, guild) from the lines.",
    CB_HIDE_GUILD        = "Remove guilds from the tooltip",
    CB_HIDE_GUILD_TIP    = "Hides guild-related lines.",
    CB_HIDE_WARBAND      = "Remove the Warband from the tooltip",
    CB_HIDE_WARBAND_TIP  = "Hides the Warband line in tooltips.",
    CB_HIDE_REALM        = "Remove the realm from the tooltip",
    CB_HIDE_REALM_TIP    = "Hides the realm next to character names in tooltips.",
    CB_DISABLE_TOOLTIP   = "Disable the ViewerLog tooltip",
    CB_DISABLE_TOOLTIP_TIP = "Hides ViewerLog's additions to item tooltips.\n|cffaaaaaa(Takes effect immediately, both ways.)|r",

    SECTION_CHARACTERS  = "  Characters",
    SECTION_GUILDS       = "  Guilds",
    SECTION_DEPENDENCIES = "  Dependencies",
    SECTION_DEP_VL       = "ViewerLog",
    SECTION_DEP_AVL      = "AltViewerLog",

    SECTION_REMINDERS       = "  Reminders",
    CB_EVENT_REMINDER       = "Calendar event reminder",
    CB_EVENT_REMINDER_TIP   = "Chat message when a character signed up for a calendar event is getting close to its start time.\n|cffaaaaaa(Requires the ViewerLog_Reminder dependency.)|r",
    CB_MAIL_REMINDER        = "Mail expiration reminder",
    CB_MAIL_REMINDER_TIP    = "Chat message when a character's pending mail is getting close to expiring.\n|cffaaaaaa(Requires the ViewerLog_Reminder dependency.)|r",

    DEP_TOOLTIP          = "Tooltip |cffb45cff(ViewerLog_Tooltip)|r",
    DEP_GUILD            = "Guild |cff4a9eff(ViewerLog_Guild)|r",
    DEP_REPUT            = "Reputations |cffb45cff(ViewerLog_Reput)|r",
    DEP_PROF             = "Professions |cff4ade80(ViewerLog_Professions)|r",
    DEP_MONNAIE          = "Currencies |cffb45cff(ViewerLog_Monnaie)|r",
    DEP_RECETTE          = "Recipes |cff4ade80(ViewerLog_Recette)|r",
    DEP_HOUSING          = "Housing |cff4ade80(ViewerLog_Housing)|r",
    DEP_REMINDER         = "Reminders |cff4ade80(ViewerLog_Reminder)|r",
    -- AltViewerLog column (right)
    DEP_AVL_CORE         = "AltViewerLog |cff4da6ff(core)|r",
    DEP_AVL_GUILD        = "Guild |cff4a9eff(AltViewerLog_GuildeLog)|r",
    DEP_AVL_REPUT        = "Reputations |cffb45cff(AltViewerLog_Reput)|r",
    DEP_AVL_PROF         = "Professions |cff4ade80(AltViewerLog_Professions)|r",
    DEP_AVL_GRAPH        = "Graph |cff4da6ff(AltViewerLog_Graph)|r",
    DEP_AVL_MONNAIE      = "Currencies |cffb45cff(AltViewerLog_Monnaie)|r",
    DEP_AVL_RECETTE      = "Recipes |cff4ade80(AltViewerLog_Recette)|r",
    DEP_VL_TIP           = "Enables or disables this ViewerLog module, along with its associated AltViewerLog module.\n|cffaaaaaa(Requires a /reload)|r",
    DEP_AVL_TIP          = "Enables or disables only this AltViewerLog module, without touching ViewerLog.\n|cffaaaaaa(Requires a /reload)|r",
    DEP_TIP              = "Enables or disables this dependency, along with its associated AltViewerLog plugin.\n|cffaaaaaa(Requires a /reload)|r",
    DEP_NOT_INSTALLED    = "Dependency not installed.",
    NO_CHAR_REGISTERED   = "No character registered.",
    NO_GUILD_SCANNED     = "No guild scanned.",

    POPUP_RELOAD_TEXT    = "This change requires an interface reload to take effect.\nReload now?",
    POPUP_RELOAD_BTN1    = "Reload",
    POPUP_RELOAD_BTN2    = "Later",
    POPUP_DEL_CHAR_TEXT  = "Delete |cffffff00%s|r from ViewerLogDB?\n|cffaaaaaa(irreversible)|r",
    POPUP_DEL_GUILD_TEXT = "Delete guild bank\n|cffffff00%s|r?\n|cffaaaaaa(irreversible)|r",

    MINIMAP_TT_CLICK     = "Left-click: Settings",

    -- Section injected into AltViewerLog's Settings panel
    VL_SECTION_DESC      = "Tooltips, characters, and guilds are managed in ViewerLog.",
    VL_OPEN_SETTINGS_BTN = "Open ViewerLog Settings",
}
