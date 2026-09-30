local addonName, pluginNs = ...

pluginNs.locales = {}

-- ── Français ─────────────────────────────────────────
pluginNs.locales["frFR"] = {
    -- Général / vue
    BTN_HOUSING          = "Housing",
    HOUSING_TITLE        = "Recettes Housing",
    SCAN_HINT            = "Ouvrez chaque métier une fois pour détecter les recettes connues.",
    NO_CHARS             = "Aucun personnage avec des recettes housing. Ouvrez un métier.",
    NO_RECIPES_PROF      = "Aucune recette housing pour ce métier.",

    -- Erreurs / debug / slash
    ERR_API_MISSING      = "ERREUR : API introuvable (ViewerLog / AltViewerLog).",
    DBG_LOADED           = "Module Housing chargé.",
    DBG_HELP             = "|cffffff00/vlhousing scan|r  |cffffff00/vlhousing debug|r",
    DBG_PASSIVE_SCAN     = "Détection housing : %s",

    -- ModelViewer (housing / catalogue)
    MV_NO_PREVIEW       = "Aperçu non disponible",
    MV_MODE_2D          = "Rendu 2D du catalogue",
    MV_MODE_ICON        = "Icône de l'item",
    MV_DEFAULT_TITLE    = "Aperçu",
    DBG_HOUSING_SCAN    = "Scan du catalogue housing :",
    DBG_ENTRIES_SCANNED = "%d entrées scannées",
    DBG_MODEL_FILEID    = "fileID du modèle affiché : %s",
    DBG_MODEL_CALIBRATE = "  → Ajoutez fileID = %s dans MODEL_POSITIONS pour calibrer la caméra",
    DBG_MODEL_CMD_HELP  = "|cffffff00/vlhmodel|r <decorID> — dump les infos d'un decorID",
    DBG_MODEL_NO_DATA   = "  Pas de données (decorID inconnu ou catalog non chargé)",
    DBG_HOUSING_API_MISSING = "C_HousingCatalog non disponible",

    -- HousingCatalog (scanner) — découverte auto
    DBG_HOUSING_DISCOVERED     = "%s : %d recette(s) housing découverte(s) automatiquement",
    DBG_HOUSING_NO_WINDOW      = "Ouvrez d'abord la fenêtre du métier.",
    DBG_HOUSING_CATEGORY_LIST  = "Catégories du métier ouvert :",
    DBG_HOUSING_SAMPLE_KEYS    = "Clés retournées par GetRecipeInfo (échantillon) :",

    -- RecipeGrid
    HOUSING_SECTION_LABEL = "Recettes %s",

    -- Barre / en-tête housing
    HOUSING_LABEL  = "Housing %d / %d",
    HOUSING_FOLD   = "Replier",
    HOUSING_UNFOLD = "Déplier",
    HOUSING_KNOWN  = "%d / %d connues",

    -- Settings
    DISABLE_2D_PREVIEW = "Afficher l'aperçu 2D des objets housing (décocher pour désactiver)",

    LEVEL_SHORT = "Niv. ",
}

-- Traduction : suit la langue de l'hôte AltViewerLog, repli GetLocale().
function pluginNs.L(key)
    local lang = (AltViewerLogDB and AltViewerLogDB.settings and AltViewerLogDB.settings.lang)
                 or GetLocale()
    local t = pluginNs.locales[lang] or pluginNs.locales["enUS"]
    return t[key] or ("[HOUSING:" .. key .. "]")
end
