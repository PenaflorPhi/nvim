return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			-- css = { "stylelint" },
			-- python = { "ruff", "pylint",  },
			c = { "clangtidy", "cpplint" },
			cpp = { "clangtidy", "cpplint" },
			go = { "golangcilint" },
			html = { "htmlhint" },
			javascript = { "oxlint", "quick-lint-js" },
			python = { "ruff" },
			rust = { "bacon" },
			sh = { "shellcheck" },
			sql = { "sqlfluff" },
		}
	end,
}
