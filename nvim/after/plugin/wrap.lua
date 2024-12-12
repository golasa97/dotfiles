vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.number = true
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.wo.relativenumber = true
    end,
})
