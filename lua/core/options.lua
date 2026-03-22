-- =============================================================================
-- Options
-- =============================================================================

-- ===== UI =====
local options = {
	number = true, -- Show absolute line number on current line
	relativenumber = true, -- Show relative line numbers for all other lines
	numberwidth = 4, -- Width of the number column
	signcolumn = "yes", -- Always show sign column (prevents layout shift)
	cursorline = true, -- Highlight the line the cursor is on
	colorcolumn = "88", -- Vertical ruler at column 88
	termguicolors = true, -- Enable 24-bit RGB colors
	background = "dark",
	-- ===== Indentation & Text Formatting =====
	expandtab = true, -- Insert spaces instead of tab characters
	shiftwidth = 4, -- Spaces used for each indentation level
	tabstop = 4, -- Visual width of a tab character
	smartindent = true, -- Auto-indent based on syntax
	linebreak = true, -- Wrap at word boundaries, not mid-word
	wrap = true, -- Enable soft line wrapping
	-- ===== Search =====
	hlsearch = true, -- Highlight all search matches
	incsearch = true, -- Show matches incrementally while typing
	ignorecase = true, -- Case-insensitive search by default
	smartcase = true, -- Override ignorecase when pattern has uppercase
	-- ===== Splits & Windows =====
	splitbelow = true, -- Horizontal splits open below current window
	splitright = true, -- Vertical splits open to the right
	-- ===== Completion & Command Line =====
	-- completeopt flags:
	--   menuone  : show popup menu even for a single match
	--   noselect : don't auto-select; confirm with <CR> or <Tab>
	-- Native completion triggers:
	--   <C-n>/<C-p>   : word completion from open buffers
	--   <C-x><C-o>    : omni completion (LSP/language-aware)
	--   <C-x><C-f>    : file path completion
	--   <C-x><C-s>    : spelling suggestions
	completeopt = { "menuone", "noselect" },
	pumheight = 10, -- Max number of items shown in completion popup
	wildmenu = true, -- Enhanced command-line completion
	wildmode = "longest:full,full", -- Complete to longest match, then cycle
	-- ===== Performance & Responsiveness =====
	updatetime = 50, -- ms before CursorHold fires (affects LSP diagnostics)
	timeoutlen = 150, -- ms to wait for a mapped key sequence to complete
	scrolloff = 8, -- Min lines to keep visible above/below cursor
	sidescroll = 8, -- Columns to scroll horizontally at a time
	-- ===== Files =====
	fileencoding = "utf-8", -- Write files as UTF-8
	autoread = true, -- Reload files changed on disk outside Neovim
	swapfile = false, -- Disable swap files
	backup = false, -- Disable backup files
	undofile = true, -- Persist undo history across sessions

	-- ===== UI Behavior =====
	cmdheight = 1, -- Command line height (1 = default single line)
	laststatus = 2, -- Always show status line
	showmode = true, -- Show current mode in command line (INSERT, etc.)
	-- ===== Folding =====
	-- viewoptions controls what mkview/loadview saves per buffer.
	-- "folds"  : saves manually created folds
	-- "cursor" : saves and restores cursor position
	viewoptions = "folds,cursor",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- =============================================================================
-- Providers
-- =============================================================================
-- Disable unused providers to suppress checkhealth warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Pin the Python interpreter used by the pynvim host.
-- Without this, Neovim resolves python3 from $PATH, which can pick up a venv
-- or conda environment and break Python-based plugins.
vim.g.python3_host_prog = "/usr/bin/python3"

-- =============================================================================
-- Deferred Options
-- =============================================================================
-- clipboard and spell are deferred via vim.schedule to avoid startup overhead
-- and ensure they are set after the UI is fully initialized.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus" -- Sync Neovim clipboard with system clipboard
	vim.opt.spell = true
	vim.opt.spelllang = { "en", "es" }
	vim.opt.spellsuggest = "10" -- Max spelling suggestions shown
end)

-- =============================================================================
-- Autocommands
-- =============================================================================
-- Persist and restore fold state (and cursor position) per buffer.
-- Skips special buffers (help, terminal, quickfix, etc.) that have no
-- meaningful view state to save.
local function is_normal_buffer()
	return vim.bo.filetype ~= "" and not vim.bo.buftype:match("nofile|terminal|prompt|quickfix")
end

vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*",
	callback = function()
		if is_normal_buffer() then
			vim.cmd("mkview")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if is_normal_buffer() then
			vim.cmd("silent! loadview")
		end
	end,
})
