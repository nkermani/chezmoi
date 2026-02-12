local ok, nnp = pcall(require, "no-neck-pain")
if not ok then return end

nnp.setup({
    width = 120,
    autocmds = {
        enableOnVimEnter = false,
        enableOnTabEnter = true,
        skipEnteringNoNeckPainOnFileType = { "oil", "dashboard", "telescope", "Trouble", "qf" },
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
