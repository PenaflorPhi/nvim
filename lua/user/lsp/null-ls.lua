require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.shfmt, -- Shell
		require("null-ls").builtins.formatting.clang_format.with{
      extra_args = {"--style=LLVM"},
    }, -- C/C++
		require("null-ls").builtins.formatting.stylua, -- Lua
		require("null-ls").builtins.formatting.black.with({
			extra_args = { "--fast" },
		}), -- Python
		require("null-ls").builtins.formatting.latexindent, -- LaTeX
		-- Diagnostics
		require("null-ls").builtins.diagnostics.shellcheck, -- Shell
		require("null-ls").builtins.diagnostics.cppcheck, -- C/C++
		require("null-ls").builtins.diagnostics.flake8, -- Python
    require("null-ls").builtins.diagnostics.chktex, -- LaTeX
	},

  require("null-ls").setup({
    on_init = function(new_client, _) 
      new_client.offset_encoding = 'utf-32'
    end,
  })
})
