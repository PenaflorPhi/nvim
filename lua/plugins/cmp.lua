return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/nvim-cmp",
		"neovim/nvim-lspconfig",
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
	},

	config = function()
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-k>"] = cmp.mapping.complete(), -- Open completion with docs
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
				{ name = "path" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- Set up lspconfig.
		local lspconfig = require("lspconfig")

		-- Enable capabilities for better completion and features
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Define a function to set up LSP servers easily
		local function setup_servers()
			local servers = {
				"bashls", -- Bash (bash-language-server)
				"gopls", -- Go
				"html", -- HTML (html-lsp)
				"jdtls", -- Java
				"lua_ls", -- Lua (lua-language-server)
				"mdx_analyzer", -- MDX (mdx-analyzer)
				"omnisharp", -- C# (OmniSharp)
				"pyright", -- Python
				"ruff", -- Python Linter (Ruff)
				"sqls", -- SQL
				"superhtml", -- SuperHTML
				"ts_ls", -- TypeScript/JavaScript (typescript-language-server)
			}

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end
		end
		setup_servers()
		require("lspconfig")["clangd"].setup({
			capabilities = capabilities,
			cmd = { "clangd", "--background-index", "--clang-tidy" },
		})

		vim.keymap.set("n", "<leader>a", function()
			vim.lsp.buf.code_action({ apply = true })
		end, { desc = "Apply LSP Fix" })

		-- Add fixes on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				vim.lsp.buf.code_action({ apply = true })
			end,
		})
	end,
}
