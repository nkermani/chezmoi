local ok, nnp = pcall(require, "no-neck-pain")
if not ok then return end

nnp.setup({
    width = 60,
    autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
    },
    mappings = {
        enabled = true,
        toggle = "<leader>np",
    },
    buffers = {
        right = {
            enabled = false,
        },
        colors = {
            background = "NONE",
        },
    },
})
