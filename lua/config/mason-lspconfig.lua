require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({})
	end,

	["pyright"] = function()
		require("lspconfig").pyright.setup({
			on_init = function(client)
				client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
				client.config.settings.venvPath = path.join(vim.env.PYENV_ROOT, "versions")
				client.config.settings.venv = get_venv(client.config.root_dir)
			end,
		})
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
