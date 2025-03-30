return {
	"stevearc/conform.nvim",
	config = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})

		require("conform").setup({
			formatters_by_ft = {
				["*"] = { "trim_whitespace", "trim_newlines" },
				bash = { "beautysh" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				go = { "gofmt" },
				h = { "clang-format" },
				hpp = { "clang-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				md = { "mdformat" },
				python = { "isort", "black", "ruff", "ruff_fix", "ruff_format", "ruff_organize_imports" },
				rust = { "rustfmt", lsp_format = "fallback" },
				sql = { "sql_formatter" },
				kotlin = { "ktfmt" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 1000,
				lsp_format = "fallback",
			},

			formatters = {
				sql_formatter = {
					args = {
						"--language=postgresql",
						'--config={"tabWidth": 4, "keywordCase": "upper"}',
					},
				},
				["clang-format"] = {
					args = { "-style=file:/home/angel/.config/clang/clang-format" },
				},
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format()
		end, { desc = "Format buffer" })
	end,
}
