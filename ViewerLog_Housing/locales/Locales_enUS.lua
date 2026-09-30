local addonName, pluginNs = ...

-- ── English ──────────────────────────────────────────
pluginNs.locales["enUS"] = {
    BTN_HOUSING          = "Housing",
    HOUSING_TITLE        = "Housing Recipes",
    SCAN_HINT            = "Open each profession once to detect known recipes.",
    NO_CHARS             = "No character with housing recipes. Open a profession.",
    NO_RECIPES_PROF      = "No housing recipes for this profession.",

    ERR_API_MISSING      = "ERROR: API not found (ViewerLog / AltViewerLog).",
    DBG_LOADED           = "Housing module loaded.",
    DBG_HELP             = "|cffffff00/vlhousing scan|r  |cffffff00/vlhousing debug|r",
    DBG_PASSIVE_SCAN     = "Housing detection: %s",

    MV_NO_PREVIEW       = "Preview unavailable",
    MV_MODE_2D          = "2D catalog render",
    MV_MODE_ICON        = "Item icon",
    MV_DEFAULT_TITLE    = "Preview",
    DBG_HOUSING_SCAN    = "Housing catalog scan:",
    DBG_ENTRIES_SCANNED = "%d entries scanned",
    DBG_MODEL_FILEID    = "Displayed model fileID: %s",
    DBG_MODEL_CALIBRATE = "  → Add fileID = %s to MODEL_POSITIONS to calibrate the camera",
    DBG_MODEL_CMD_HELP  = "|cffffff00/vlhmodel|r <decorID> — dumps info for a decorID",
    DBG_MODEL_NO_DATA   = "  No data (unknown decorID or catalog not loaded)",
    DBG_HOUSING_API_MISSING = "C_HousingCatalog not available",

    DBG_HOUSING_DISCOVERED     = "%s: %d housing recipe(s) auto-discovered",
    DBG_HOUSING_NO_WINDOW      = "Open the profession window first.",
    DBG_HOUSING_CATEGORY_LIST  = "Categories of the open profession:",
    DBG_HOUSING_SAMPLE_KEYS    = "Keys returned by GetRecipeInfo (sample):",

    HOUSING_SECTION_LABEL = "Recipes %s",

    HOUSING_LABEL  = "Housing %d / %d",
    HOUSING_FOLD   = "Collapse",
    HOUSING_UNFOLD = "Expand",
    HOUSING_KNOWN  = "%d / %d known",

    DISABLE_2D_PREVIEW = "Show 2D preview for housing items (uncheck to disable)",

    LEVEL_SHORT = "Lvl ",
}
