return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- C / C++
			require("lspconfig").clangd.setup({})
		end,
	},
	{
		"benomahony/uv.nvim",
		opts = {
			picker_integration = true,
		},
	},
}
