vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ""
vim.opt_local.formatoptions:append("ro")

local reset = "setlocal wrap< linebreak< breakindent< spell< conceallevel< concealcursor< formatoptions<"
vim.b.undo_ftplugin = (vim.b.undo_ftplugin and (vim.b.undo_ftplugin .. " | ") or "") .. reset
