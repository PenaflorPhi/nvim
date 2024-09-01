require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({})
	end,

	["ruff_lsp"] = function()
		require("lspconfig")["ruff_lsp"].setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.hoverProvider = false
			end,
			on_init = function(client)
				client.config.interpreter = get_python_path(client.config.root_dir)
			end,
		})
	end,
})
