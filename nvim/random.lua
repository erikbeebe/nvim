-- map leader to <Space>
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- toggle line numbers and sign column
function toggle_linenumbers()
    vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
    vim.o.relativenumber = not vim.o.relativenumber
    vim.o.number = not vim.o.number
end

vim.keymap.set('n', '<Leader>nn', '<cmd>lua toggle_linenumbers()<cr>')

-- clangd helpers
vim.keymap.set('n', '<Leader>K', vim.lsp.buf.hover)
vim.keymap.set('n', '<Leader><C-k>', vim.lsp.buf.signature_help)
