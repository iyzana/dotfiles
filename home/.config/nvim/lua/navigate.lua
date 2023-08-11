-- leader key
vim.g.mapleader = " "

-- split navigation
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

-- terminal
vim.keymap.set("n", "<leader>c", "<cmd>90vs +terminal<cr>a", { silent = true })
vim.keymap.set("n", "<leader>C", "<cmd>sp +terminal<cr>a", { silent = true })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.api.nvim_create_autocmd("BufEnter", { pattern = { "term://*" }, command = "startinsert" })
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber norelativenumber nospell" })

-- clear screen
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<cr>", { silent = true })

-- keep on indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- nerdtree
vim.keymap.set("n", "<leader>o", "<cmd>NERDTreeToggle<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>NERDTreeFind<cr>")

-- switch files
vim.keymap.set("n", "go", "<cmd>Alternate<cr>")

-- fzf
vim.keymap.set("n", "<leader>p", "<cmd>AllFiles<cr>")
vim.keymap.set("n", "<C-p>", "<cmd>Files<cr>")
vim.keymap.set("n", "<C-f>", "<cmd>Rg<cr>")
vim.keymap.set("v", "<C-f>", "y:Rg <C-r>\"<cr>")
vim.keymap.set("n", "<C-b>", "<cmd>Buffers<cr>")

vim.g.fzf_preview_window = { 'right:50%:hidden', '´' }

vim.api.nvim_command(
	"command! -bang -nargs=* Rg "..
		"call fzf#vim#grep("..
			"'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),"..
			"1,"..
			"fzf#vim#with_preview(),"..
			"<bang>0"..
		")"
)

-- vim.api.nvim_command(
-- 	"command! -bang -nargs=? -complete=dir Files "..
-- 		"call fzf#vim#files("..
-- 			"<q-args>,"..
-- 			"fzf#vim#with_preview('right:50%:hidden', '´'),"..
-- 			"<bang>0"..
-- 		")"
-- )

vim.api.nvim_command(
	"command! -bang -nargs=* AllFiles "..
		"call fzf#run("..
			"fzf#wrap("..
				"fzf#vim#with_preview("..
					"{'source': 'fd --type f --no-ignore --hidden '.shellescape(<q-args>)},"..
					"'right:50%:hidden',"..
					"'´'"..
				")"..
			")"..
		")"
)

-- only match parantheses for selector "b"
vim.api.nvim_create_autocmd("User", {
	pattern = { "targets#mappings#user" },
	command = "call targets#mappings#extend({ 'b': {'pair': [{'o': '(', 'c': ')'}]} })"
})
