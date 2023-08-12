-- use 4 spaces for indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
vim.opt.expandtab = false
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undofile = true

vim.opt.scrolloff = 3
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  { pattern = { "term://*" }, command = "setlocal scrolloff=0" }
)

-- skip "Process exited 0" on terminal exit
vim.api.nvim_create_autocmd(
  { "TermClose" },
  { pattern = { "*" }, command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif" }
)

-- reduce update time
vim.opt.updatetime = 250

-- highlight on yank
vim.api.nvim_create_autocmd(
  { "TextYankPost" },
  { pattern = { "*" }, command = "silent! lua vim.highlight.on_yank({timeout=500})" }
)

vim.g.coc_data_home = vim.env.HOME .. "/.local/share/coc"

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- exclude # from default file name pattern
vim.opt.isfname = "@,48-57,/,.,-,_,+,,,$,%,~,="

-- spelling correction
vim.opt.spell = true

-- ignore sign when inc/decrementing
vim.opt.nrformats:append('unsigned')
