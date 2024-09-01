return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				c = { "clang-format" },
				go = { "gofmt" },
				lua = { "stylua" },
				python = { "isort", "ruff", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				css = { "prettierd" },
				html = { "prettierd" },
				js = { "prettierd" },
				sh = { "beautysh", "shftm" },
				["*"] = { "trim_whitespace" },
			},
			format_on_save = {
				timeout_ms = 2000,
				lsp_format = "fallback",
			},
		})
	end,
}
