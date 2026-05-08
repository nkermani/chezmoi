local ok, precognition = pcall(require, "precognition")
if ok then
  precognition.setup({
    highlightColor = { link = "Comment" },
  })
end
