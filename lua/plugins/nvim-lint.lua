return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			python = { "ruff", "flake8", "pylint" },
			-- c = { "clang-tidy" },
			-- cpp = { "clang-tidy" },
			lua = { "luacheck" },
			markdown = { "markdownlint" },
			javascript = { "eslint" },
			go = { "golangci-lint" },
			html = { "htmlhint" },
			css = { "stylelint" },
			sql = { "sqlfluff" },
		}
		-- Auto-run linting on buffer writes
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
