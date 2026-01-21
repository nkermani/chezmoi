#!/bin/bash

# Dossier cible pour tes plugins natifs
PLUGIN_DIR="$HOME/.local/share/nvim/site/pack/external/start"
mkdir -p "$PLUGIN_DIR"

echo "📥 Installation des plugins Neovim natifs..."

# Liste de tes plugins
PLUGINS=(
    "nvim-neo-tree/neo-tree.nvim"
    "nvim-lua/plenary.nvim"
    "nvim-tree/nvim-web-devicons"
    "MunifTanjim/nui.nvim"
    "rebelot/kanagawa.nvim"
    "sainnhe/sonokai"
    "xiyaowong/transparent.nvim"
    "goolord/alpha-nvim"
    "folke/noice.nvim"
    "lukas-reineke/indent-blankline.nvim"
    "nvim-lualine/lualine.nvim"
    "nvim-telescope/telescope.nvim"
    "folke/trouble.nvim"
    "akinsho/bufferline.nvim"
    "neovim/nvim-lspconfig"
    "hrsh7th/nvim-cmp"
    "hrsh7th/cmp-nvim-lsp"
    "hrsh7th/cmp-buffer"
    "hrsh7th/cmp-path"
    "zbirenbaum/copilot.lua"
    "nvim-treesitter/nvim-treesitter"
    "windwp/nvim-autopairs"
    "stevearc/conform.nvim"
    "lewis6991/gitsigns.nvim"
    "MeanderingProgrammer/render-markdown.nvim"
    "mg979/vim-visual-multi"
    "folke/snacks.nvim"
    "nvim-pack/nvim-spectre"
    "ahmedkhalf/project.nvim"
    "numToStr/Comment.nvim"
    "inhesrom/remote-ssh.nvim"
)

for plugin in "${PLUGINS[@]}"; do
    folder=$(basename "$plugin")
    if [ ! -d "$PLUGIN_DIR/$folder" ]; then
        echo "Clonage de $folder..."
        git clone --depth=1 "https://github.com/$plugin" "$PLUGIN_DIR/$folder"
    else
        echo "✅ $folder est déjà là."
    fi
done

# Mise à jour de Treesitter une fois terminé
echo "🌲 Mise à jour de Treesitter..."
nvim --headless -c "TSUpdate" -c "quit" || true

