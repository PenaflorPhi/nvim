-- Keymaps
-- Leader configuration
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Default options for mappings
local default_opts = { noremap = true, silent = true }
local function map(mode, lhs, rhs, desc, opts)
	local o = opts and vim.tbl_extend("force", default_opts, opts) or default_opts
	if desc then
		o.desc = desc
	end
	vim.keymap.set(mode, lhs, rhs, o)
end

-- Helper: smart file explorer toggle (NvimTree if available, else netrw)
local function toggle_explorer()
	local ok, api = pcall(require, "nvim-tree.api")
	if ok then
		api.tree.toggle()
	else
		vim.cmd("Ex")
	end
end

-- Helper: toggles for booleans (wrap, relativenumber, spell, etc.)
local function toggle_opt(optname)
	vim.opt[optname] = not vim.opt[optname]:get()
end

-- ====================================================================
-- File Explorer
-- ====================================================================
map("n", "<leader>e", toggle_explorer, "File explorer")

-- ====================================================================
-- Windows
-- ====================================================================
-- Move between splits
map("n", "<C-Left>", "<C-w>h", "Go to left window")
map("n", "<C-Down>", "<C-w>j", "Go to below window")
map("n", "<C-Up>", "<C-w>k", "Go to above window")
map("n", "<C-Right>", "<C-w>l", "Go to right window")

-- Resize splits
map("n", "<A-Left>", "<C-w><", "Shrink width")
map("n", "<A-Right>", "<C-w>>", "Grow width")
map("n", "<A-Up>", "<C-w>+", "Grow height")
map("n", "<A-Down>", "<C-w>-", "Shrink height")
map("n", "<leader>=", "<C-w>=", "Equalize splits")

-- ====================================================================
-- Editing
-- ====================================================================
-- Keep half-page jumps centered (restores <C-d>/<C-u> default behavior)
map("n", "<C-d>", "<C-d>zz", "Half-page down, centered")
map("n", "<C-u>", "<C-u>zz", "Half-page up, centered")

-- Clear search highlight
map("n", "<leader>/", ":nohlsearch<CR>", "Clear search highlight")

-- Indent/unindent and stay in visual
map("v", "<Tab>", ">gv", "Indent selection")
map("v", "<S-Tab>", "<gv", "Unindent selection")
map("v", "<", "<gv", "Unindent selection")
map("v", ">", ">gv", "Indent selection")

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==", "Move line down")
map("n", "<A-k>", ":m .-2<CR>==", "Move line up")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up")
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move block down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move block up")

-- Yank to end of line (consistency with C/Y behavior)
map("n", "Y", "y$", "Yank to end of line")

-- Word deletion: rely on built-ins
--   Insert mode: <C-w> deletes previous word; <C-u> deletes to BOL.
--   Normal mode: 'dw', 'db', etc. are already optimal.
-- (<C-BS> is unreliable across terminals, so we omit it.)

-- ====================================================================
-- Spelling / Dictionary
-- ====================================================================
map("n", "<leader>sn", "]s", "Next misspelling")
map("n", "<leader>sp", "[s", "Prev misspelling")
map("n", "<leader>ss", "z=", "Suggestions")
map("n", "<leader>sa", "zg", "Add word")
map("n", "<leader>su", "zug", "Undo add")
map("n", "<leader>st", function()
	toggle_opt("spell")
end, "Toggle spell")

-- ====================================================================
-- Diagnostics
-- ====================================================================
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
map("n", "<leader>de", vim.diagnostic.open_float, "Line diagnostics")
map("n", "<leader>dq", vim.diagnostic.setloclist, "Diagnostics to loclist")

-- ====================================================================
-- Search quality-of-life
-- ====================================================================
map("n", "n", "nzzzv", "Next search result centered")
map("n", "N", "Nzzzv", "Prev search result centered")

-- ====================================================================
-- Telescope (under <leader>T…)
-- ====================================================================
local function T(picker, opts)
	local ok, tb = pcall(require, "telescope.builtin")
	if not ok then
		vim.notify("Telescope not installed", vim.log.levels.WARN)
		return
	end
	tb[picker](opts or {})
end

map("n", "<leader>tf", function()
	T("find_files")
end, "Telescope: Find files")
map("n", "<leader>tg", function()
	T("live_grep")
end, "Telescope: Live grep")
map("n", "<leader>tb", function()
	T("buffers")
end, "Telescope: Buffers")
map("n", "<leader>th", function()
	T("help_tags")
end, "Telescope: Help tags")
map("n", "<leader>tr", function()
	T("resume")
end, "Telescope: Resume")
map("n", "<leader>tc", function()
	T("commands")
end, "Telescope: Commands")
-- LSP-aware pickers (only do something when LSP attached)
map("n", "<leader>ts", function()
	T("lsp_document_symbols")
end, "Telescope: Doc symbols")
map("n", "<leader>tw", function()
	T("lsp_dynamic_workspace_symbols")
end, "Telescope: WS symbols")
map("n", "<leader>tk", function()
	T("keymaps")
end, "Telescope: Keymaps")

-- === Diagnostics nav ===
-- Note: <leader>N is uppercase 'N' (previous); <leader>n is lowercase (next).
-- In Vim notation, <S-n> == 'N', so don’t try <leader><S-n>—it’s the same key.
local diag_float = { border = "rounded", source = "if_many" }
map("n", "<leader>N", function()
	vim.diagnostic.goto_prev({ float = diag_float })
end, "Diagnostics: Previous")
map("n", "<leader>n", function()
	vim.diagnostic.goto_next({ float = diag_float })
end, "Diagnostics: Next")

-- === Docs on <C-k> ===
-- No plugin needed: built-in LSP provides hover + signature help.
-- Normal: hover docs; Insert: signature help.
-- Caveat: this overrides digraphs (<C-k>), and may conflict if your completion plugin already uses <C-k>.
map("n", "<C-k>", vim.lsp.buf.hover, "LSP: Hover documentation")
map("i", "<C-k>", function()
	vim.lsp.buf.signature_help()
end, "LSP: Signature help")

-- OPTIONAL: if you often want 'K' (shift-k) to hover (traditional Neovim lore)
-- map("n", "K", vim.lsp.buf.hover, "LSP: Hover (K)")
--
-- === Copilot ===
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

-- Accept with <leader><Tab>
map(
	"i",
	"<leader><Tab>",
	'copilot#Accept("\\<CR>")',
	"Copilot: Accept",
	{ expr = true, silent = true, replace_keycodes = false }
)

-- Trigger suggestion (pick one that your terminal passes through)
map("i", "<C-j>", "copilot#Suggest()", "Copilot: Suggest", { expr = true, silent = true })
-- or: map("i", "<C-Space>", 'copilot#Suggest()', "Copilot: Suggest", { expr = true, silent = true })

-- Cycle and dismiss
map("i", "<C-n>", "copilot#Next()", "Copilot: Next", { expr = true, silent = true })
map("i", "<C-p>", "copilot#Previous()", "Copilot: Previous", { expr = true, silent = true })
map("i", "<C-]>", "copilot#Dismiss()", "Copilot: Dismiss", { expr = true, silent = true })
