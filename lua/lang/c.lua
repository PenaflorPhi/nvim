local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
	on_attach = function(client, bufnr)
		-- Enable inlay hints (Neovim 0.10+)
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		-- Keymaps
		local opts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("v", "<leader>a", vim.lsp.buf.code_action, opts)
	end,
})
