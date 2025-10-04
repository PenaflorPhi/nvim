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
					{ name = "luasnip" }, -- was "vsnip"
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
			-- lazy spec: remove "neovim/nvim-lspconfig"
			-- keep cmp-nvim-lsp for capabilities if you want
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				clangd = { cmd = { "clangd" }, roots = { ".git", "compile_commands.json" } },
				pyright = {
					cmd = { "pyright-langserver", "--stdio" },
					roots = { ".git", "pyproject.toml", "setup.py" },
				},
				gopls = { cmd = { "gopls" }, roots = { ".git", "go.work", "go.mod" } },
				tsserver = {
					cmd = { "typescript-language-server", "--stdio" },
					roots = { "package.json", "tsconfig.json", ".git" },
				},
				html = { cmd = { "vscode-html-language-server", "--stdio" }, roots = { ".git" } },
				cssls = { cmd = { "vscode-css-language-server", "--stdio" }, roots = { ".git" } },
				jsonls = { cmd = { "vscode-json-language-server", "--stdio" }, roots = { ".git" } },
				bashls = { cmd = { "bash-language-server", "start" }, roots = { ".git" } },
				lua_ls = { cmd = { "lua-language-server" }, roots = { ".git" } },
				marksman = { cmd = { "marksman", "server" }, roots = { ".git" } },
				yamlls = { cmd = { "yaml-language-server", "--stdio" }, roots = { ".git" } },
				dockerls = { cmd = { "docker-langserver", "--stdio" }, roots = { ".git" } },
				taplo = { cmd = { "taplo", "lsp", "stdio" }, roots = { ".git", "taplo.toml" } },
				-- add others as needed
			}

			local function root_from(bufnr, markers)
				return vim.fs.root(bufnr or 0, markers) or vim.loop.cwd()
			end

			local function on_attach(client, bufnr)
				-- your keymaps go here
			end

			-- start LSP per buffer by filetype
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"c",
					"cpp",
					"objc",
					"objcpp",
					"cuda",
					"python",
					"go",
					"typescript",
					"javascript",
					"html",
					"css",
					"json",
					"sh",
					"lua",
					"markdown",
					"yaml",
					"dockerfile",
					"toml",
				},
				callback = function(args)
					local ft = args.match
					local map = {
						c = "clangd",
						cpp = "clangd",
						objc = "clangd",
						objcpp = "clangd",
						cuda = "clangd",
						python = "pyright",
						go = "gopls",
						typescript = "tsserver",
						javascript = "tsserver",
						html = "html",
						css = "cssls",
						json = "jsonls",
						sh = "bashls",
						lua = "lua_ls",
						markdown = "marksman",
						yaml = "yamlls",
						dockerfile = "dockerls",
						toml = "taplo",
					}
					local name = map[ft]
					local s = name and servers[name]
					if not s then
						return
					end
					vim.lsp.start({
						name = name,
						cmd = s.cmd, -- required
						root_dir = root_from(args.buf, s.roots),
						on_attach = on_attach,
						capabilities = capabilities,
						settings = name == "lua_ls" and {
							Lua = {
								diagnostics = { globals = { "vim" } },
								workspace = { checkThirdParty = false },
							},
						} or nil,
					})
				end,
			})
		end,
	},
}
