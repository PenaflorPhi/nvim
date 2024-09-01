return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			c = { "clangtidy" },
			css = { "stylelint" },
			html = { "htmlhint" },
			javascript = { "oxlint", "quick-lint-js" },
			python = { "ruff" },
			-- python = { "ruff", "pylint" },
			go = { "golangcilint" },
			sql = { "sqlfluff" },
			sh = { "shellcheck" },
		}
	end,
}
