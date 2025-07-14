return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ruff",
				"pyright",
				"bashls",
				"dockerls",
				"gopls",
				"html",
				"superhtml",
				"jdtls",
				"ts_ls",
				"mdx_analyzer",
				"sqls",
				"omnisharp",
			},
		})
	end,
}
