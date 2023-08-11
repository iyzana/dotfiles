vim.g.firenvim_config = {
    localSettings = {
        [".*"] = {
					selector = 'textarea:not([readonly]):not(.xterm-helper-textarea), div[role="textbox"]'
        },
        ["https://github.com/.*/.*/blob/.*/.*"] = {
            takeover = "never"
        },
        ["https://planka.iyzana.site/.*"] = {
            takeover = "never"
        },
        ["https://(www\\.)?(google|bing|regexr|regex101|deepl).com/.*"] = {
            takeover = "never"
        }
    }
}

vim.api.nvim_create_autocmd({'UIEnter'}, {
    callback = function(event)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
            vim.o.laststatus = 0
						vim.o.number = false
						vim.o.relativenumber = false
						vim.o.guifont = 'monospace:h10'
						vim.o.linebreak = true
        end
    end
})
