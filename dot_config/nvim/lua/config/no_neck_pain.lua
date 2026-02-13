local ok, nnp = pcall(require, "no-neck-pain")
if not ok then return end

nnp.setup({
    width = 100,
    autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
        skipEnteringNoNeckPainOnFileType = { "dashboard", "telescope", "Trouble", "qf", "oil" },
    },
    mappings = {
        enabled = true,
        toggle = "<leader>np",
    },
    buffers = {
        left = { enabled = true, width = 0.02 },
        right = { enabled = true, width = 0.02 },
        colors = {
            background = "NONE",
        },
    },
})
