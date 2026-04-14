return {
	"stevearc/conform.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "ruff_fix", "ruff_format" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true }, -- optional but common
			c = { "clang-format" },
			cpp = { "clang-format" },
			cmake = { "cmake_format" },
			rs = { "rustfmt" },
			toml = { "tombi" },
		},
		-- Use function form so it actually sets up the BufWritePre autocmd
		format_on_save = function(_)
			return { timeout_ms = 500, lsp_fallback = true }
		end,
	},
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format with Conform",
		},
	},
}
