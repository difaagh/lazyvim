-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- copy to clipboard
function CopyToDevClipboard()
    local old_reg = vim.fn.getreg('"')  -- save current register contents
    vim.cmd([[normal! gv]])  -- select current visual area
    local selection = vim.fn.getreg('"')  -- get content of selection
    os.execute('echo ' .. vim.fn.shellescape(selection) .. ' > /dev/clipboard')  -- write selection to /dev/clipboard
    vim.fn.setreg('"', old_reg)  -- restore original register contents
end

-- Map the function <leader>y in normal mode
vim.api.nvim_set_keymap('n', '<leader>y', ':lua CopyToDevClipboard()<CR>', { noremap = true, silent = true })
