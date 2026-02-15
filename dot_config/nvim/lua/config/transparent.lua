-- lua/config/transparent.lua
-- xiyaowong/transparent.nvim -> Remove all background colors to make nvim transparent.
local ok, transparent = pcall(require, "transparent")
if not ok then return end

transparent.setup({
    extra_groups = {
        -- =====================================================================
        -- 1. BASE & POPUPS
        -- =====================================================================
        -- 'NormalFloat',
        -- 'FloatBorder',
        -- 'NvimTreeNormal',

        -- =====================================================================
        -- 2. NEOTREE
        -- =====================================================================
        -- 'NeoTreeNormal',
        -- 'NeoTreeNormalNC',
        -- 'NeoTreeVertSplit',
        -- 'NeoTreeWinSeparator',
        -- 'NeoTreeEndOfBuffer',
        -- 'NeoTreeRootName',
        -- 'NeoTreeDirectoryName',
        -- 'NeoTreeFileName',

        -- =====================================================================
        -- 3. BUFFERLINE (TABS)
        -- =====================================================================
        -- 'BufferLineFill',       -- L'arrière-plan vide derrière les onglets
        -- 'BufferLineBackground', -- Les onglets inactifs
        -- 'BufferLineSeparator',  -- Les séparateurs entre onglets
        -- 'BufferLineSeparatorVisible',
        -- 'BufferLineSeparatorSelected',
        -- 'BufferLineTab', -- Les onglets de type "Tab"
        -- 'BufferLineTabSelected',
        -- 'BufferLineTabSeparator',
        -- 'BufferLineTabSeparatorSelected',
        -- 'BufferLineIndicatorSelected', -- Le petit indicateur de sélection
        -- 'BufferLineOffsetSeparator',
        -- 'BufferLineTabClose',
        -- 'BufferLineCloseButton',
        -- 'BufferLineCloseButtonSelected',
        -- 'BufferLineFill',
        -- 'BufferLineIndicatorSelected',

        -- =====================================================================
        -- 4. STATUSLINE (LUALINE) - ACTIVE
        -- =====================================================================
        'StatusLine',
        'StatusLineNC',
        'lualine_c_normal',   -- Le milieu en mode Normal
        'lualine_c_insert',   -- Le milieu en mode Insert
        'lualine_c_visual',   -- Le milieu en mode Visual
        'lualine_c_replace',  -- Le milieu en mode Replace
        'lualine_c_command',  -- Le milieu en mode Command
        'lualine_c_inactive', -- Le milieu quand la fenêtre n'est pas focus

        -- =====================================================================
        -- 5. TELESCOPE - ACTIVE
        -- =====================================================================
        'TelescopeNormal',         -- Fond de la fenêtre principale
        'TelescopeBorder',         -- Bordures des fenêtres
        'TelescopePromptNormal',   -- Fond de la barre de recherche
        'TelescopePromptBorder',   -- Bordure de la barre de recherche
        'TelescopeResultsNormal',  -- Fond de la liste des résultats
        'TelescopeResultsBorder',  -- Bordure de la liste des résultats
        'TelescopePreviewNormal',  -- Fond de la prévisualisation
        'TelescopePreviewBorder',  -- Bordure de la prévisualisation
        'TelescopeTitle',          -- Titre des fenêtres
        'TelescopePromptPrefix',   -- Préfixe de la recherche
        'TelescopeSelection',      -- Élément sélectionné
        'TelescopeSelectionCaret', -- Curseur de sélection

        -- =====================================================================
        -- 6. NOICE (CMDLINE & NOTIFICATIONS)
        -- =====================================================================
        -- 'NoiceCmdlinePopup',       -- Fond de la fenêtre
        -- 'NoiceCmdlinePopupBorder', -- Bordure de la fenêtre
        -- 'NoiceCmdlinePopupTitle',  -- Titre si présent
        -- 'NoiceCmdlineIcon',        -- L'icône (le ">" ou l'icône de recherche)
        -- 'NoiceCmdlineIconSearch',  -- Spécifique à la recherche "/"
        -- 'NoiceConfirm',            -- Fenêtres de confirmation
        -- 'NoiceConfirmBorder',      -- Bordure de confirmation
        -- 'NoicePopupmenu',          -- Menu de complétion de Noice
        -- 'NoicePopupmenuBorder',    -- Bordure de la complétion

        -- =====================================================================
        -- 7. SNACKS (NOTIFICATIONS)
        -- =====================================================================
        -- 'SnacksNotifier',
        -- 'SnacksNotifierBorder',
        -- 'SnacksNormal',
        -- 'SnacksBackdrop',

        -- =====================================================================
        -- 8. ALPHA (DASHBOARD)
        -- =====================================================================
        -- 'AlphaHeader',
        -- 'AlphaButtons',
        -- 'AlphaNormal',
        -- 'AlphaShortcut',
        -- 'AlphaFooter',

        -- =====================================================================
        -- 9. AUTOCOMPLETION & MENUS (PMENU)
        -- =====================================================================
        -- 'Pmenu',      -- Fond du menu popup (clic droit, autocomplétion)
        -- 'PmenuSel',   -- Fond de l'élément sélectionné dans le menu
        -- 'PmenuSbar',  -- Barre de défilement du menu
        -- 'PmenuThumb', -- Curseur de la barre de défilement

        -- =====================================================================
        -- 10. PLUGINS DIVERS (Lazy, VM, etc.)
        -- =====================================================================
        -- 'LazyNormal',
        -- 'VM_Cursor',
        -- 'VM_Extend',
        -- 'VM_Insert',
    },
    exclude_groups = {
        -- Groupes de base à garder opaques
        -- 'Normal',
        -- 'NormalNC',
        'SignColumn',
        'EndOfBuffer',
        'NvimTreeNormal',
        'NeoTreeNormal',

        -- 1. Garder la ligne actuelle (CursorLine) opaque
        'CursorLine',
        'CursorLineNr', -- Le numéro de ligne correspondant

        -- 2. Garder les éléments de Lualine (NORMAL, ligne:col) opaques
        'lualine_a_normal',
        'lualine_a_insert',
        'lualine_a_visual',
        'lualine_a_command',
        'lualine_a_replace',
        'lualine_b_normal',
        -- 'lualine_c_normal', -- Optionnel : garde le milieu de la barre opaque
        'lualine_z_normal', -- C'est souvent ici que se trouve "ligne:col"
        'lualine_z_insert',
        'lualine_z_visual',
    },
})

-- Force le nettoyage des préfixes pour Lualine (assure une transparence totale)
transparent.clear_prefix('lualine')

-- BufferLine n'est plus transparent, donc on commente ça
-- transparent.clear_prefix('BufferLine')

transparent.toggle(false)
