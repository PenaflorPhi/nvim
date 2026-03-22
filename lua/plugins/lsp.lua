-- lsp.lua
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lspconfig").clangd.setup({})
		end,
	},
}
