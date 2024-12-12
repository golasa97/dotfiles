
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    -- Map <Enter> to insert \item automatically
    vim.keymap.set("i", "<CR>", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("^%s*\\item") then
        return "\n\\item "
      else
        return "\n"
      end
    end, { buffer = true, expr = true })

    -- Map 'o' to add a new \item below
    vim.keymap.set("n", "o", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("^%s*\\item") then
        return "o\\item "
      else
        return "o"
      end
    end, { buffer = true, expr = true })

    -- Map 'O' to add a new \item above
    vim.keymap.set("n", "O", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("^%s*\\item") then
        return "O\\item "
      else
        return "O"
      end
    end, { buffer = true, expr = true })
  end,
})
