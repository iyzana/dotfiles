vim.opt.spelllang = "en,de_20,hun-de-DE-frami"

-- tex
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
  build_dir = "build",
  continuous = 1,
  options = {
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
    "-shell-escape",
    -- "-output-directory=build"
  },
}

-- csv
vim.g.csv_no_conceal = 1

-- nav
vim.g.AlternatePath = {}
vim.g.AlternateExtensionMappings = {
  {
    [".js"] = ".ts",
    [".ts"] = ".tsx",
    [".tsx"] = ".html",
    [".html"] = ".css",
    [".css"] = ".scss",
    [".scss"] = ".js",
  },
  {
    [".component.ts"] = ".component.html",
    [".component.html"] = ".component.scss",
    [".component.scss"] = ".component.css",
    [".component.css"] = ".component.ts",
  }
}

vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = { "*.cue" }, command = "setf cue" }
)
