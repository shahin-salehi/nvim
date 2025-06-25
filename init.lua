require("user.options")
require("user.plugins")
require("user.lsp")
require("user.snippets")
require("user.templ")

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

vim.keymap.set('i', '<C-8>', '{}<Left>', { noremap = true, silent = true })

vim.keymap.set("i","c8","{}<Esc>i<Return><Esc>O")
vim.keymap.set("i","v8","[]<Esc>i")



