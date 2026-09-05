return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = "markdown",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		file_types = { "markdown" },
		html = { enabled = false },
		latex = { enabled = false },
		yaml = { enabled = false },
		win_options = {
			conceallevel = {
				default = 2,
				rendered = 3,
			},
			concealcursor = {
				default = "",
				rendered = "",
			},
		},
	},
}
