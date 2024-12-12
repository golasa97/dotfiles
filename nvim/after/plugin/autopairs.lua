local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
local luasnip = require('luasnip')

npairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
})

-- cmp integration with autopairs
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- Define the custom tab function for autopairs and LuaSnip
_G.MPairs = {}
_G.MPairs.autopairs_tab = function()

    -- Check if the next character is a closing pair
    local col = vim.fn.col('.') -- Current column position
    local line = vim.fn.getline('.') -- Current line text
    local next_char = line:sub(col, col) -- Character under the cursor
    local pair_end_chars = { ')', ']', '}', '"', "'", '`', '$' } -- Possible pair ending characters

    if vim.tbl_contains(pair_end_chars, next_char) then
        return npairs.esc('<Right>') -- Move out of the pair
    end

    -- Default: Insert a tab character
    return npairs.esc('<Tab>')
end

-- Define the shift-tab function
_G.MPairs.autopairs_shift_tab = function()
    -- Get the current line and cursor position
    local col = vim.fn.col('.') -- Current column position
    local line = vim.fn.getline('.') -- Current line text
    local prev_char = line:sub(col - 1, col - 1) -- Character before the cursor
    local pair_start_chars = { '(', '[', '{', '"', "'", '`', '$' } -- Possible opening characters

    -- If the previous character is a pair start, move backward
    if vim.tbl_contains(pair_start_chars, prev_char) then
        return npairs.esc('<Left>') -- Move cursor left
    end

    -- Otherwise, perform a shift-tab (fallback behavior)
    return npairs.esc('<S-Tab>')
end


-- Keymap for <Tab>
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.MPairs.autopairs_tab()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.MPairs.autopairs_tab()', { expr = true, noremap = true })

-- Keymap for <S-Tab>
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.MPairs.autopairs_shift_tab()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.MPairs.autopairs_shift_tab()', { expr = true, noremap = true })

-- Additional rules for autopairs
npairs.add_rules({
    Rule("$", "$", { "tex", "latex" })
        :with_pair(cond.not_after_regex("%%"))
        :with_pair(cond.not_before_regex("xxx", 3))
        :with_move(cond.none())
        :with_del(cond.not_after_regex("xx"))
        :with_cr(cond.none()),
    Rule("$$", "$$", "tex")
        :with_pair(function(opts)
            if opts.line == "aa $$" then
                return false -- Disable pair on specific lines
            end
        end),
})
