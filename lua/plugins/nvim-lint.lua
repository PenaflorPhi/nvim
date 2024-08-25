return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			c = { "clangtidy" },
			css = { "eslint_d" },
			html = { "eslint_d" },
			javascript = { "eslint_d" },
			python = { "ruff", "pylint" },
			go = { "golangcilint" },
			sql = { "sqlfluff" },
		}
	end,
}
