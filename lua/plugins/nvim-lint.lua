return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			c = { "clangtidy" },
			css = { "stylelint" },
			html = { "htmlhint" },
			javascript = { "eslint_d" },
			python = { "ruff", "pylint" },
			go = { "golangcilint" },
			sql = { "sqlfluff" },
		}
	end,
}
