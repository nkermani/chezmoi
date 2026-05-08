local ok, yazi = pcall(require, "yazi")
if ok then
  yazi.setup({
    open_for_directories = false,
    clipboard_register = "*",
    keys = {
      show_help = "<f1>",
    },
  })
end
