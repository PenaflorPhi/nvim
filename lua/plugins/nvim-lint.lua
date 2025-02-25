return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			python = { "ruff", "flake8", "pylint" },
			c = { "clang-tidy" },
			cpp = { "clang-tidy" },
			lua = { "luacheck" },
			markdown = { "markdownlint" },
			javascript = { "eslint" },
			go = { "golangci-lint" },
			html = { "htmlhint" },
			css = { "stylelint" },
		}

		-- Auto-run linting on buffer writes
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "LintResult",
			callback = function()
				local diagnostics = vim.diagnostic.get(0)
				for _, d in ipairs(diagnostics) do
					vim.api.nvim_buf_set_virtual_text(0, -1, d.lnum, { { d.message, "WarningMsg" } }, {})
				end
			end,
		})
	end,
}
