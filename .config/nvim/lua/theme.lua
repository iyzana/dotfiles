-- colorscheme
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- coc overrides
local setCocColors = function()
  vim.api.nvim_set_hl(0, "CocHighlightText", { bg = "#223922", underline = true, ctermbg = 2 })
  vim.api.nvim_set_hl(0, "CocInlayHint", { link = "Comment" })
  -- vim.api.nvim_set_hl(0, "CocErrorSign", { fg = "fg" })
  vim.api.nvim_set_hl(0, "CocFloatDividingLine", { link = "CocFloating" })
end
vim.api.nvim_create_autocmd({ "ColorScheme" }, { callback = setCocColors })

vim.api.nvim_command("colorscheme PaperColor")

vim.g.gitgutter_sign_added = "•"
vim.g.gitgutter_sign_modified = "•"
vim.g.gitgutter_sign_modified_removed = "•"

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
