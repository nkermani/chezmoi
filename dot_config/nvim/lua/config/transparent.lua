-- lua/config/transparent.lua
-- xiyaowong/transparent.nvim -> Remove all background colors to make nvim transparent.
local ok, transparent = pcall(require, "transparent")
if not ok then return end

transparent.setup({
    extra_groups = {
        'NormalFloat',
        'NvimTreeNormal',
        -- Dans ton extra_groups de transparent.lua
        'NeoTreeNormal',
        'NeoTreeNormalNC',
        'NeoTreeVertSplit',
        'NeoTreeWinSeparator',
        'NeoTreeEndOfBuffer',
        'NeoTreeRootName',
        'NeoTreeDirectoryName',
        'NeoTreeFileName',

        'BufferLineFill',       -- L'arrière-plan vide derrière les onglets
        'BufferLineBackground', -- Les onglets inactifs
        'BufferLineSeparator',  -- Les séparateurs entre onglets
        'BufferLineSeparatorVisible',
        'BufferLineSeparatorSelected',
        'BufferLineTab', -- Les onglets de type "Tab"
        'BufferLineTabSelected',
        'BufferLineTabSeparator',
        'BufferLineTabSeparatorSelected',
        'BufferLineIndicatorSelected', -- Le petit indicateur de sélection
        'BufferLineOffsetSeparator',
        'BufferLineTabClose',
        'BufferLineCloseButton',
        'BufferLineCloseButtonSelected',
        'BufferLineFill',
        'BufferLineIndicatorSelected',

        'StatusLine',
        'StatusLineNC',
        'LazyNormal',

        -- Dans ton extra_groups de transparent.lua
        'SnacksNotifier',
        'SnacksNotifierBorder',
        'SnacksNormal',
        'SnacksBackdrop', -- Utile pour le focus

        -- Dans extra_groups de transparent.lua
        'AlphaHeader',
        'AlphaButtons',
        'AlphaNormal',
        'AlphaShortcut',
        'AlphaFooter',
        'NoiceCmdlinePopup',       -- Fond de la fenêtre
        'NoiceCmdlinePopupBorder', -- Bordure de la fenêtre
        'NoiceCmdlinePopupTitle',  -- Titre si présent
        'NoiceCmdlineIcon',        -- L'icône (le ">" ou l'icône de recherche)
        'NoiceCmdlineIconSearch',  -- Spécifique à la recherche "/"
        'NoiceConfirm',            -- Fenêtres de confirmation
        'NoiceConfirmBorder',      -- Bordure de confirmation
        'NoicePopupmenu',          -- Menu de complétion de Noice
        'NoicePopupmenuBorder',    -- Bordure de la complétion

        'TelescopeNormal',         -- Fond de la fenêtre principale
        'TelescopeBorder',         -- Bordures des fenêtres
        'TelescopePromptNormal',   -- Fond de la barre de recherche
        'TelescopePromptBorder',   -- Bordure de la barre de recherche
        'TelescopeResultsNormal',  -- Fond de la liste des résultats
        'TelescopeResultsBorder',  -- Bordure de la liste des résultats
        'TelescopePreviewNormal',  -- Fond de la prévisualisation
        'TelescopePreviewBorder',  -- Bordure de la prévisualisation

        -- Dans extra_groups de transparent.lua
        'VM_Cursor',
        'VM_Extend',
        'VM_Insert',

        -- AJOUTS POUR LE CLIC DROIT ET MENUS POPUP
        'Pmenu',      -- Fond du menu popup (clic droit, autocomplétion)
        'PmenuSel',   -- Fond de l'élément sélectionné dans le menu
        'PmenuSbar',  -- Barre de défilement du menu
        'PmenuThumb', -- Curseur de la barre de défilement

        -- GROUPES LUALINE
        'lualine_c_normal',   -- Le milieu en mode Normal
        'lualine_c_insert',   -- Le milieu en mode Insert
        'lualine_c_visual',   -- Le milieu en mode Visual
        'lualine_c_replace',  -- Le milieu en mode Replace
        'lualine_c_command',  -- Le milieu en mode Command
        'lualine_c_inactive', -- Le milieu quand la fenêtre n'est pas focus
    },
    exclude_groups = {
        'lualine_a_normal',
        'lualine_a_insert',
        'lualine_a_visual',
        'lualine_a_command',
    },
})

transparent.clear_prefix('lualine')
transparent.clear_prefix('BufferLine')
transparent.toggle(true)

