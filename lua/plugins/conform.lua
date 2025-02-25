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
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black", "ruff", "ruff_fix", "ruff_format", "ruff_organize_imports" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
				bash = { "beautysh" },
				go = { "gofmt" },
				c = { "clang-format" },
				h = { "clang-format" },
				cpp = { "clang-format" },
				hpp = { "clang-format" },
				sql = { "sql_formatter" },
				["*"] = { "trim_whitespace", "trim_newlines" },
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
