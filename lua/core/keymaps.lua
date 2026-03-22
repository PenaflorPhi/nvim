-- =============================================================================
-- Keymaps
-- =============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- Helpers
-- =============================================================================
local default_opts = { noremap = true, silent = true }

local function map(mode, lhs, rhs, desc, opts)
	local o = opts and vim.tbl_extend("force", default_opts, opts) or default_opts
	if desc then
		o.desc = desc
	end
	vim.keymap.set(mode, lhs, rhs, o)
end

-- Toggles a boolean vim option by name
local function toggle_opt(optname)
	vim.opt[optname] = not vim.opt[optname]:get()
end

-- Opens nvim-tree if available, falls back to netrw
local function toggle_explorer()
	local ok, api = pcall(require, "nvim-tree.api")
	if ok then
		api.tree.toggle()
	else
		vim.cmd("Ex")
	end
end

-- Wraps a Telescope builtin call with a graceful fallback if Telescope is missing
local function T(picker, opts)
	local ok, tb = pcall(require, "telescope.builtin")
	if not ok then
		vim.notify("Telescope not installed", vim.log.levels.WARN)
		return
	end
	tb[picker](opts or {})
end

-- =============================================================================
-- File Explorer
-- =============================================================================
map("n", "<leader>e", toggle_explorer, "File explorer")

-- =============================================================================
-- Windows
-- =============================================================================
-- Navigation
map("n", "<C-Left>", "<C-w>h", "Go to left window")
map("n", "<C-Down>", "<C-w>j", "Go to below window")
map("n", "<C-Up>", "<C-w>k", "Go to above window")
map("n", "<C-Right>", "<C-w>l", "Go to right window")

-- Resizing
map("n", "<A-Left>", "<C-w><", "Shrink width")
map("n", "<A-Right>", "<C-w>>", "Grow width")
map("n", "<A-Up>", "<C-w>+", "Grow height")
map("n", "<A-Down>", "<C-w>-", "Shrink height")
map("n", "<leader>=", "<C-w>=", "Equalize splits")

-- =============================================================================
-- Buffers
-- =============================================================================
map("n", "<leader>c", function()
	vim.cmd("bdelete " .. vim.api.nvim_get_current_buf())
end, "Close buffer")

-- =============================================================================
-- Editing
-- =============================================================================
-- Scrolling (keep cursor centered)
map("n", "<C-d>", "<C-d>zz", "Half-page down, centered")
map("n", "<C-u>", "<C-u>zz", "Half-page up, centered")

-- Indentation (preserves visual selection after indent)
map("v", "<Tab>", ">gv", "Indent selection")
map("v", "<S-Tab>", "<gv", "Unindent selection")
map("v", "<", "<gv", "Unindent selection")
map("v", ">", ">gv", "Indent selection")

-- Line/block movement
map("n", "<A-j>", ":m .+1<CR>==", "Move line down")
map("n", "<A-k>", ":m .-2<CR>==", "Move line up")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up")
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move block down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move block up")

-- Yank
map("n", "Y", "y$", "Yank to end of line")

-- =============================================================================
-- Search
-- =============================================================================
map("n", "<leader>/", ":nohlsearch<CR>", "Clear search highlight")

-- Keep search results centered and unfold the match location
map("n", "n", "nzzzv", "Next search result, centered")
map("n", "N", "Nzzzv", "Prev search result, centered")

-- =============================================================================
-- Spelling
-- =============================================================================
map("n", "<leader>sn", "]s", "Next misspelling")
map("n", "<leader>sp", "[s", "Prev misspelling")
map("n", "<leader>ss", "z=", "Spelling suggestions")
map("n", "<leader>sa", "zg", "Add word to dictionary")
map("n", "<leader>su", "zug", "Undo add word")
map("n", "<leader>st", function()
	toggle_opt("spell")
end, "Toggle spell check")

-- =============================================================================
-- Diagnostics
-- =============================================================================

-- Rounded float with source shown only when multiple sources are present
local diag_float = { border = "rounded", source = "if_many" }

map("n", "]d", function()
	vim.diagnostic.goto_next({ float = diag_float })
end, "Next diagnostic")
map("n", "[d", function()
	vim.diagnostic.goto_prev({ float = diag_float })
end, "Prev diagnostic")
map("n", "<leader>n", function()
	vim.diagnostic.goto_next({ float = diag_float })
end, "Diagnostics: Next")
map("n", "<leader>N", function()
	vim.diagnostic.goto_prev({ float = diag_float })
end, "Diagnostics: Prev")
map("n", "<leader>de", vim.diagnostic.open_float, "Line diagnostics float")
map("n", "<leader>dq", vim.diagnostic.setloclist, "Send diagnostics to loclist")

-- =============================================================================
-- Telescope
-- =============================================================================

-- Files & text
map("n", "<leader>tf", function()
	T("find_files")
end, "Telescope: Find files")
map("n", "<leader>tg", function()
	T("live_grep")
end, "Telescope: Live grep")
map("n", "<leader>tr", function()
	T("resume")
end, "Telescope: Resume last picker")

-- Buffers & help
map("n", "<leader>tb", function()
	T("buffers")
end, "Telescope: Buffers")
map("n", "<leader>th", function()
	T("help_tags")
end, "Telescope: Help tags")
map("n", "<leader>tc", function()
	T("commands")
end, "Telescope: Commands")
map("n", "<leader>tk", function()
	T("keymaps")
end, "Telescope: Keymaps")

-- LSP-backed pickers
map("n", "<leader>ts", function()
	T("lsp_document_symbols")
end, "Telescope: Document symbols")
map("n", "<leader>tw", function()
	T("lsp_dynamic_workspace_symbols")
end, "Telescope: Workspace symbols")

-- =============================================================================
-- LSP
-- =============================================================================

-- on_attach is called by the LspAttach autocmd below and registers
-- buffer-local keymaps only for buffers where an LSP client is active.
local M = {}

M.on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	local function lmap(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
	end

	-- Navigation
	lmap("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
	lmap("n", "gr", vim.lsp.buf.references, "LSP: References")

	-- Documentation
	lmap("n", "<C-k>", vim.lsp.buf.hover, "LSP: Hover docs")
	lmap("i", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature help")

	-- Refactoring
	lmap("n", "<leader>r", vim.lsp.buf.rename, "LSP: Rename symbol")
	lmap({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, "LSP: Code action")
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		M.on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
	end,
})

return M
