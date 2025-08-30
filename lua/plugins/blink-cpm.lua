return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      -- Snippets (engine + collection)
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "rafamadriz/friendly-snippets",
    },
    opts = {
      -- No preset: explicit mappings
      keymap = {
        preset = "none",
        ["<Tab>"] = {
          function(cmp)
            -- define this helper once (see below)
            if has_words_before() then
              return cmp.insert_next()
            end
            return "fallback"
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "insert_prev" },
        ["<C-Space>"] = { "show", "show_documentation" },
        ["<C-e>"] = { "hide" },
      },

      appearance = { nerd_font_variant = "mono" },

      completion = {
        documentation = {
          window = { border = "single" },
          auto_show = true, -- fine; turn off if it distracts
        },
        list = {
          selection = { preselect = false },
          cycle = { from_top = false },
        },
      },

      signature = { -- fixed typo
        enabled = true,
        window = { border = "single" },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      fuzzy = { implementation = "prefer_rust" },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      -- minimal helper used above
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end
      _G.has_words_before = has_words_before

      require("blink.cmp").setup(opts)

      -- Snippets: lazy-load VSCode collections
      local ls = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = false,
      })
    end,
  },
}
