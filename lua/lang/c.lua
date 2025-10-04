-- Neovim 0.11+ (no lspconfig)
local function clangd_on_attach(client, bufnr)
	local inlay_enabled = true
	if vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(inlay_enabled, { bufnr = bufnr })
	end
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>ih", function()
		inlay_enabled = not inlay_enabled
		vim.lsp.inlay_hint.enable(inlay_enabled, { bufnr = bufnr })
	end, { desc = "Toggle Inlay Hints", buffer = bufnr })
end

local clangd_cfg = {
	name = "clangd",
	cmd = { "clangd" }, -- required: table, not string
	root_dir = vim.fs.root(0, { ".git", "compile_commands.json" }) or vim.loop.cwd(),
	on_attach = clangd_on_attach,
}

-- start for C/C++ buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
	callback = function()
		vim.lsp.start(clangd_cfg)
	end,
})
