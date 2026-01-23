#!/bin/bash
# Dossier cible pour tes plugins natifs
PLUGIN_DIR="$HOME/.local/share/nvim/site/pack/external/start"
mkdir -p "$PLUGIN_DIR"

echo "📥 Installation des plugins Neovim natifs..."

# Liste de tes plugins
PLUGINS=(
    "nvim-lua/plenary.nvim"
    "nvim-tree/nvim-web-devicons"
    "MunifTanjim/nui.nvim"
    "rebelot/kanagawa.nvim"
    "cpea2506/one_monokai.nvim"
    "sainnhe/sonokai"
    "xiyaowong/transparent.nvim"
    "folke/noice.nvim"
    "nvim-lualine/lualine.nvim"
    "nvim-telescope/telescope.nvim"
    "folke/trouble.nvim"
    "neovim/nvim-lspconfig"
    "mason-org/mason.nvim"
    "mason-org/mason-lspconfig.nvim"
    "hrsh7th/nvim-cmp"
    "hrsh7th/cmp-nvim-lsp"
    "hrsh7th/cmp-buffer"
    "hrsh7th/cmp-path"
    "nvim-treesitter/nvim-treesitter"
    "windwp/nvim-autopairs"
    "stevearc/conform.nvim"
    "lewis6991/gitsigns.nvim"
    "mg979/vim-visual-multi"
    "folke/snacks.nvim"
    "nvim-pack/nvim-spectre"
    "zbirenbaum/copilot.lua"
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
