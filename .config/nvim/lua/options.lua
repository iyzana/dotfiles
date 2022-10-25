-- use 4 spaces for indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true

vim.opt.scrolloff = 3

vim.api.nvim_create_autocmd(
  { "BufEnter" },
  { pattern = { "term://*" }, command = "setlocal scrolloff=0" }
)

vim.opt.hidden = true
vim.opt.undofile = true

vim.opt.lazyredraw = true
vim.opt.inccommand = "nosplit"

vim.opt.mouse = "nvi"

vim.api.nvim_exec([[
  function! ProjectPath()
   return fnamemodify(getcwd(), ":~")
  endfunction
]], false)

vim.opt.title = true
vim.opt.titlestring = "nvim %{ProjectPath()} - %t"

vim.opt.autowriteall = true

-- reduce update time
vim.opt.updatetime = 250

-- autosave
vim.api.nvim_create_autocmd(
  { "FocusLost" },
  { pattern = { "*" }, command = "wa" }
)
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  { pattern = { "term://*" }, command = "wa" }
)

vim.g.coc_data_home = vim.env.HOME .. "/.local/share/coc"
vim.g.polyglot_disabled = {"latex"}

vim.g.firenvim_config = {
  globalSettings = {},
  localSettings = {
    ['.*'] = {
      takeover = "never",
      priority = 1
    }
  }
}
