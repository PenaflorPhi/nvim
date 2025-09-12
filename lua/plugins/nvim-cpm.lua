return {
	-- Completion core + sources
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- sources
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")

			-- helper: non-space before cursor?
			local function has_words_before()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				if col == 0 then
					return false
				end
				local text = vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
				return not text:match("^%s*$")
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						-- if you switch engines later:
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),

					-- Super Tab
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback() -- insert indent
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
					-- { name = "ai" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				-- window = {
				--   completion = cmp.config.window.bordered(),
				--   documentation = cmp.config.window.bordered(),
				-- },
			})

			-- Cmdline completion
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},

	-- LSP config (capabilities + servers)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- EDIT this list as you like
			local servers = {
				"pyright",
				"clangd",
				"gopls",
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"bashls",
				"lua_ls",
				"marksman",
				"yamlls",
				"dockerls",
				"docker_compose_language_service",
				"taplo",
			}

			local function on_attach(_, _)
				-- add per-buffer LSP keymaps here if you want
			end

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			-- lua_ls: friendlier defaults for Neovim config (optional)
			if lspconfig.lua_ls then
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
						},
					},
				})
			end
		end,
	},
}
