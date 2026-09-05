local attach_group = vim.api.nvim_create_augroup("config.rust_lsp", { clear = true })
local format_group = vim.api.nvim_create_augroup("config.rust_format", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = attach_group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or client.name ~= "rust_analyzer" or vim.bo[args.buf].filetype ~= "rust" then
			return
		end

		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			vim.keymap.set("n", "<leader>uh", function()
				local filter = { bufnr = args.buf }
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
			end, { buffer = args.buf, desc = "Toggle inlay hints" })
		end

		if client:supports_method("textDocument/formatting") then
			local function format()
				vim.lsp.buf.format({
					bufnr = args.buf,
					name = "rust_analyzer",
					timeout_ms = 3000,
				})
			end

			vim.keymap.set("n", "<leader>cf", format, {
				buffer = args.buf,
				desc = "Format Rust buffer",
			})

			vim.api.nvim_clear_autocmds({ group = format_group, buffer = args.buf })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = format_group,
				buffer = args.buf,
				callback = format,
				desc = "Format Rust buffer on save",
			})
		end
	end,
})

vim.lsp.config("rust_analyzer", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
})

vim.lsp.enable("rust_analyzer")
