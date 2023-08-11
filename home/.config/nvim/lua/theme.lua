-- colorscheme
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.g.gitgutter_sign_added = "•"
vim.g.gitgutter_sign_modified = "•"
vim.g.gitgutter_sign_modified_removed = "•"

vim.g.gitgutter_set_sign_backgrounds = true

-- coc overrides
local onColorUpdate = function()
  vim.api.nvim_set_hl(0, "CocHighlightText", { bg = "#223922", underline = true })
  vim.api.nvim_set_hl(0, "CocInlayHint", { link = "Comment" })
  vim.api.nvim_set_hl(0, "CocFloatDividingLine", { link = "CocFloating" })

  vim.api.nvim_set_hl(0, "SignColumn", { link = "LineNr" })
  
  for _, hl in ipairs({"CocErrorSign", "CocWarningSign", "CocInfoSign", "CocHintSign"}) do
    vim.cmd('highlight ' .. hl .. ' guibg=none')
  end

  vim.cmd('highlight GitGutterChange guifg=#6c6ed8')
  vim.cmd('highlight Normal guibg=NONE')
end
vim.api.nvim_create_autocmd({ "ColorScheme" }, { callback = onColorUpdate })

if vim.g.started_by_firenvim == true then
	vim.api.nvim_command("colorscheme ayu")
else
	vim.api.nvim_command("colorscheme gruvbox8_hard")
end

-- use theme colors for fzf
vim.g.fzf_colors = {
  fg = {'fg', 'Normal'},
  bg = {'bg', 'Normal'},
  hl = {'fg', 'Comment'},
  ['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
  ['bg+'] = {'bg', 'Normal'},
  ['hl+'] = {'fg', 'Statement'},
  info = {'fg', 'PreProc'},
  border = {'fg', 'Comment'},
  prompt = {'fg', 'Conditional'},
  pointer = {'fg', 'Exception'},
  marker = {'fg', 'Keyword'},
  spinner = {'fg', 'Label'},
  header = {'fg', 'Comment'}
}
