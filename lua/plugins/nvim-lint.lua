return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			-- c = { "clang-tidy" },
			-- cpp = { "clang-tidy" },
			css = { "stylelint" },
			go = { "golangci-lint" },
			html = { "htmlhint" },
			javascript = { "eslint" },
			lua = { "luacheck" },
			-- markdown = { "markdownlint" },
			python = { "ruff" },
			sql = { "sqlfluff" },
			dockerfile = { "hadolint" },
			-- kotlin = { "ktlint" },
		}
		-- Auto-run linting on buffer writes
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
