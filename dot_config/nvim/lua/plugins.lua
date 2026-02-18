-- lua/plugins.lua
local pack = vim.pack

pack.add({
    -- 핵심 유틸리티 / Core Utilities / Utilitaires de base
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/MunifTanjim/nui.nvim' },

    -- 테마 및 미학 / Themes & Aesthetics / Thèmes et Esthétique
    { src = 'https://github.com/rebelot/kanagawa.nvim' },
    { src = 'https://github.com/cpea2506/one_monokai.nvim' },
    { src = 'https://github.com/sainnhe/sonokai' },
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/Mofiqul/vscode.nvim' },
    { src = 'https://github.com/sainnhe/everforest' },
    { src = 'https://github.com/projekt0n/github-nvim-theme' },
    { src = 'https://github.com/sainnhe/gruvbox-material' },
    { src = 'https://github.com/loctvl842/monokai-pro.nvim' },
    { src = 'https://github.com/datsfilipe/vesper.nvim' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/scottmckendry/cyberdream.nvim' },
    { src = 'https://github.com/xiyaowong/transparent.nvim' },
    { src = 'https://github.com/folke/noice.nvim' },

    -- 상태 표시줄 및 내비게이션 / Statusline & Navigation / Barre d'état et Navigation
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/akinsho/bufferline.nvim' },
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
    { src = 'https://github.com/folke/edgy.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/folke/trouble.nvim' },

    -- LSP 및 지능형 기능 / LSP & Intelligence / LSP et Intelligence
    -- { src = 'https://github.com/neovim/nvim-lspconfig' },
    -- { src = 'https://github.com/mason-org/mason.nvim' },
    -- { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/hrsh7th/nvim-cmp' },

    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-buffer' },
    { src = 'https://github.com/hrsh7th/cmp-path' },
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
    { src = 'https://github.com/ray-x/lsp_signature.nvim' },
    { src = 'https://github.com/zbirenbaum/copilot.lua' },

    -- 구문 및 편집 / Syntax & Editing / Syntaxe et Édition
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    { src = 'https://github.com/windwp/nvim-autopairs' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },

    -- Multicurseurs (Style VSCode)
    { src = 'https://github.com/mg979/vim-visual-multi' },

    -- 다목적 도구 / Swiss Army Knife / Couteau Suisse
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/nvim-pack/nvim-spectre' },
    { src = 'https://github.com/letieu/btw.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/bassamsdata/namu.nvim' },
    { src = 'https://github.com/YouSame2/inlinediff-nvim' },
    { src = 'https://github.com/malewicz1337/oil-git.nvim' },
    { src = 'https://github.com/esmuellert/codediff.nvim' },
    { src = 'https://github.com/stevearc/dressing.nvim' },
    { src = 'https://github.com/tris203/precognition.nvim' },
})
