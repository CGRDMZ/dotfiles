return {
	"neovim/nvim-lspconfig",
	ft = "rust",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("config.lsp")
	end,
}
