local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

null_ls.setup({
	sources = {
		require("null-ls").builtins.formatting.shfmt, -- Shell
		require("null-ls").builtins.formatting.stylua, -- Lua
		-- require("null-ls").builtins.formatting.
		require("null-ls").builtins.formatting.black.with({
			extra_args = { "--fast" },
		}), -- Python
		require("null-ls").builtins.formatting.latexindent, -- LaTeX
		-- Diagnostics
		require("null-ls").builtins.diagnostics.shellcheck, -- Shell
		require("null-ls").builtins.diagnostics.cppcheck, -- C/C++
		require("null-ls").builtins.diagnostics.flake8, -- Python
		-- require("null-ls").builtins.diagnostics.chktex, -- Throws a fuckton of errors with no explanation.
		require("null-ls").builtins.formatting.clang_format.with({
			extra_args = { "--style=LLVM" },
		}), -- C/C++
	},
})

