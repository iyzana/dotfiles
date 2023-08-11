local treesitter = require 'nvim-treesitter.configs'

treesitter.setup {
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    }
}

-- local ts_utils = require 'nvim-treesitter.ts_utils'
--
-- local function show_node()
--     print(ts_utils.get_node_at_cursor())
-- end

local setTreesitterMappings = function()
    vim.api.nvim_set_hl(0, "@attribute", { link = "Operator" })
    vim.api.nvim_set_hl(0, "@tag.attribute", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Type" })
    vim.api.nvim_set_hl(0, "@text.diff.add", { link = "diffAdded" })
    vim.api.nvim_set_hl(0, "@text.diff.delete", { link = "diffRemoved" })
    vim.api.nvim_set_hl(0, "@text.diff.change", { link = "diffChanged" })

    local nohl={"@variable", "@parameter", "@function.call", "Delimiter"}
    for _, hl in ipairs(nohl) do
        vim.api.nvim_set_hl(0, hl, { fg = "fg" })
    end
end

vim.api.nvim_create_autocmd({ "ColorScheme" }, { callback = setTreesitterMappings })
