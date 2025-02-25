return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	vim.keymap.set("n", "<leader>k", require("telescope.builtin").lsp_document_symbols),
}
