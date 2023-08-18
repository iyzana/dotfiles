require("substitute").setup({})

vim.keymap.set("n", "s", require('substitute').operator)
vim.keymap.set("n", "ss", require('substitute').line)
vim.keymap.set("x", "s", require('substitute').visual)

-- Y for clipboard
vim.keymap.set("n", "Y", "\"+")
vim.keymap.set("v", "Y", "\"+")

-- autosave
vim.opt.autowriteall = true

vim.api.nvim_create_autocmd(
  { "FocusLost" },
  { command = "silent! wa" }
)
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  { pattern = { "term://*" }, command = "silent! wa" }
)

