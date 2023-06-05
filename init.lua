local root_dir = vim.fn.fnamemodify(vim.trim(vim.fn.system("git rev-parse --show-toplevel")), ":p")

package.path = string.format("%s;%s?.lua;%s?/init.lua", package.path, root_dir, root_dir)

vim.opt.packpath:prepend(string.format("%s", root_dir .. "site"))

vim.opt.rtp = {
    root_dir,
    vim.env.VIMRUNTIME,
}

vim.cmd([[
      filetype on
      packadd nvim-treesitter
]])

vim.opt.swapfile = false

vim.cmd([[
      runtime plugin/nvim-treesitter-textobjects
]])

require"nvim-treesitter.configs".setup {
    ensure_installed = { "zig" },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = true,
        },
    },
}
