return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {},
	config = function(_, opts)
		require("bufferline").setup(opts)

		-- Move between buffers with Ctrl-Tab / Ctrl-Shift-Tab
		vim.keymap.set("n", "<A-Tab>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
		vim.keymap.set("n", "<A-S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
	end,
}
