return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			picker = {
				enabled = true,
				sources = {
					explorer = {
						auto_close = true,
						jump = { close = true },
						layout = { preset = "vertical", preview = false },
					},
				},
			},
			explorer = { enabled = true },
			quickfile = { enabled = true },
		},
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Search text",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File explorer",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("]h", function()
					gitsigns.nav_hunk("next")
				end, "Next Git hunk")
				map("[h", function()
					gitsigns.nav_hunk("prev")
				end, "Previous Git hunk")
				map("<leader>hp", gitsigns.preview_hunk, "Preview Git hunk")
			end,
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			need = 1,
			branch = true,
		},
		config = function(_, opts)
			vim.opt.sessionoptions = {
				"buffers",
				"curdir",
				"folds",
				"tabpages",
				"winsize",
				"winpos",
				"localoptions",
			}

			local persistence = require("persistence")
			persistence.setup(opts)

			local external_group = vim.api.nvim_create_augroup("config.external_editor", { clear = true })
			local function stop_persistence()
				persistence.stop()
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = external_group,
				pattern = { "gitcommit", "gitrebase", "jj" },
				callback = stop_persistence,
				desc = "Do not save sessions for commit buffers",
			})

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				group = external_group,
				callback = function(args)
					local path = vim.fs.normalize(vim.api.nvim_buf_get_name(args.buf))
					local temp_roots = { vim.env.TMPDIR or "/tmp", "/tmp", "/var/tmp" }
					for _, root in ipairs(temp_roots) do
						root = vim.fs.normalize(root)
						if path == root or vim.startswith(path, root .. "/") then
							stop_persistence()
							return
						end
					end
				end,
				desc = "Do not save sessions for temporary files",
			})
		end,
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore directory session",
			},
		},
	},
}
