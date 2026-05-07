local ok, devicons = pcall(require, "nvim-web-devicons")
if ok then
  devicons.setup({ default = true })
end
