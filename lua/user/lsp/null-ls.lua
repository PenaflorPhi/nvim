local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

null_ls.setup({
	sources = {
		require("null-ls").builtins.code_actions.refactoring,
		require("null-ls").builtins.formatting.shfmt, -- Shell
		require("null-ls").builtins.diagnostics.shellcheck, -- Shell

		-- Python
		require("null-ls").builtins.diagnostics.flake8, -- Python
		require("null-ls").builtins.formatting.black, -- Python
		require("null-ls").builtins.formatting.isort,

		-- Lua
		require("null-ls").builtins.formatting.stylua, -- Lua
		require("null-ls").builtins.completion.luasnip,
		require("null-ls").builtins.diagnostics.luacheck,

		-- C
		require("null-ls").builtins.diagnostics.cpplint,
		require("null-ls").builtins.diagnostics.cppcheck,
		-- require("null-ls").builtins.diagnostics.clang_check,
		require("null-ls").builtins.formatting.clang_format.with({
			extra_args = { "--style=LLVM" },
		}),
		require("null-ls").builtins.diagnostics.checkmake,

		-- Latex
		require("null-ls").builtins.formatting.latexindent,
		require("null-ls").builtins.diagnostics.chktex,

		-- Rust
		require("null-ls").builtins.formatting.rustfmt,
		require("null-ls").builtins.formatting.asmfmt,
	},
})
