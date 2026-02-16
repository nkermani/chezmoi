-- lua/config/neotree.lua
local ok, neotree = pcall(require, "neo-tree")
if not ok then return end

neotree.setup({
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    source_selector = {
        winbar = false,
        statusline = false,
    },
    filesystem = {
        hijack_netrw_behavior = "disabled",
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
    },
    window = {
        position = "left",
        width = 35,
        mappings = {
            ["<space>"] = "none",
        }
    },
    use_default_mappings = true,
    default_component_configs = {
        indent = {
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
        },
    },
})

-- Raccourci pour ouvrir/fermer l'explorateur
vim.keymap.set('n', '<leader>e', function()
    if vim.bo.filetype == "oil" then
        require("oil").close()
        vim.cmd("Neotree show")
        return
    end
    vim.cmd("Neotree toggle")
end, { desc = "Toggle Neo-tree" })


