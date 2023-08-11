-- exit nerdtree with last split
vim.api.nvim_create_autocmd("BufEnter", { command = "if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif" })

vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeMinimalMenu = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeWinSize = 40
vim.g.NERDTreeMapHelp = '<F1>'
vim.g.nerdtree_plugin_open_cmd = "xdg-open"

vim.opt.number = true
vim.opt.relativenumber = true

-- disable statusline
vim.opt.laststatus = 2
vim.opt.ruler = false
vim.opt.showmode = false

vim.opt.shortmess:append('c')
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- whitespace rendering when enabled
vim.opt.listchars="tab:⇥ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"

-- lightline
vim.g.lightline = {
	active = {
		left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' } },
		right = { { 'lineinfo' }, { 'percent' }, { 'cocstatus', 'filetype', 'fileformat', 'fileencoding' } },
	},
	component_function = {
		cocstatus = 'coc#status'
	},
	colorscheme = 'gruvbox8'
}

-- fzf style
vim.g.fzf_layout = { window = { width = 0.8, height = 0.6 } }
vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --history=" .. vim.env.HOME .. "/.local/share/fzf-history/vim-history"

-- title
vim.opt.title = true
vim.opt.titlestring = "nvim %{ProjectPath()} - %t"
vim.api.nvim_exec([[
  function! ProjectPath()
   return fnamemodify(getcwd(), ":~")
  endfunction
]], false)

