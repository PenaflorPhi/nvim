return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				c = { "clang-format" },
				css = { "prettierd" },
				go = { "gofmt" },
				html = { "prettierd" },
				js = { "prettierd" },
				lua = { "stylua" },
				md = { "prettierd" },
				python = { "isort", "ruff", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
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
