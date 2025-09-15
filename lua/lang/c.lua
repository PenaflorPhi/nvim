local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
	on_attach = function(client, bufnr)
		-- Track state
		local inlay_enabled = true

		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(inlay_enabled, { bufnr = bufnr })
		end

		-- Keymaps
		local opts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("v", "<leader>a", vim.lsp.buf.code_action, opts)

		-- Toggle keymap
		vim.keymap.set("n", "<leader>ih", function()
			inlay_enabled = not inlay_enabled
			vim.lsp.inlay_hint.enable(inlay_enabled, { bufnr = bufnr })
		end, { desc = "Toggle Inlay Hints", buffer = bufnr })
	end,
})
