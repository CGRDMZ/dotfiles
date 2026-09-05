vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.treesitter")

-- set the colorscheme
vim.cmd("colorscheme onedark_dark")

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true


vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	signs = true,
	update_in_insert = false,
})
