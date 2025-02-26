return {
	"neovim/nvim-lspconfig",

	config = function()
		local navic = require("nvim-navic")
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Define a function to set up LSP servers easily
		local function setup_servers()
			local servers = {
				"bashls", -- Bash
				"gopls", -- Go
				"html", -- HTML
				"jdtls", -- Java
				"lua_ls", -- Lua
				"mdx_analyzer", -- MDX
				"omnisharp", -- C#
				"pyright", -- Python
				"ruff", -- Python
				"sqls", -- SQL
				"superhtml", -- HTML
				"ts_ls", -- TypeScript/JavaScript
				"clangd",
			}

			local function on_attach(client, bufnr)
				-- Enable navic if the server supports documentSymbol
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				else
					vim.notify("navic: " .. client.name .. " does not support document symbols", vim.log.levels.WARN)
				end
			end

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach, -- Attach navic
				})
			end
		end
		setup_servers()

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				-- Check if document symbols are available before attaching navic
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end
			end,
			cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
		})

		vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

		vim.keymap.set("n", "<leader>a", function()
			vim.lsp.buf.code_action({ apply = true })
		end, { desc = "Apply LSP Fix" })
	end,
}
