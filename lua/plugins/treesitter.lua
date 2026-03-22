return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			highlight = {
				enable = true,
			},
			auto_install = true,

			install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter",
		})
	end,
}
