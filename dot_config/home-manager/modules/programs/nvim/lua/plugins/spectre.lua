local ok, spectre = pcall(require, "spectre")
if ok then
  spectre.setup({
    highlight = { ui = "String", search = "DiffDelete", replace = "DiffAdd" },
  })
end
