local options = {
	title = true, -- 📝 Show the title of the file in the terminal

	hlsearch = true, -- 🔍 Highlight all search results
	ignorecase = true, -- 🔡 Ignore case in searches
	incsearch = true, -- 🔍 Show search results as you type
	linebreak = true, -- ➡️ Break lines at word boundaries
	modifiable = true, -- 🔄 Allow changes to the buffer
	smartcase = true, -- 🔠 Ignore case unless search contains uppercase
	smartindent = true, -- 🧠 Auto-indent new lines smartly
	wrap = true, -- 📜 Wrap long lines

	number = true, -- 🔢 Show line numbers
	relativenumber = true, -- 📏 Show relative line numbers
	numberwidth = 1, -- 🛠️ Set width of the number column
	signcolumn = "yes", -- ✅ Always show the sign column

	scrolloff = 8, -- 🚶 Keep 8 lines above/below the cursor when scrolling
	sidescroll = 8, -- ↔️ Horizontal scroll by 8 columns

	cmdheight = 1, -- 💬 Height of the command line
	laststatus = 2, -- 📊 Always show the status line
	pumheight = 10, -- 📜 Limit popup menu height
	showcmd = true, -- 🖥️ Show the command in the last line
	showmode = true, -- 🚥 Show the current mode (e.g., INSERT)
	showtabline = 2, -- 🗂️ Always show the tabline

	background = "dark", -- 🌑 Set background to dark (for dark themes)
	termguicolors = true, -- 🎨 Enable 24-bit colors in the terminal
	colorcolumn = "88", -- 📏 Highlight column 88 for line length guide
	cursorcolumn = true, -- 📍 Highlight the column under the cursor
	cursorline = true, -- 🖱️ Highlight the line under the cursor
	mouse = "a", -- 🖱️ Enable mouse in all modes

	expandtab = true, -- 🛠️ Convert tabs to spaces
	tabstop = 4, -- ⌨️ Number of spaces a tab counts for
	shiftwidth = 4, -- ↔️ Number of spaces to use for auto-indents

	fileencoding = "utf-8", -- 📄 Use UTF-8 file encoding
	spell = true, -- 📝 Enable spell checking
	spelllang = "en,es", -- 🌍 Spell check in English and Spanish
	spellsuggest = "10", -- 🧙 Limit spell suggestions to 10

	timeoutlen = 150, -- ⏳ Time to wait for a mapped sequence (in ms)
	updatetime = 50, -- ⏱️ Faster completion (lower time for CursorHold)
	lazyredraw = true, -- 💤 Faster macros and scripts

	backup = false, -- 🚫 Don't create backup files
	swapfile = false, -- 🚫 Don't use swap files
	undofile = true, -- 💾 Enable persistent undo
	clipboard = "unnamedplus", -- 📋 Use the system clipboard
	autoread = true, -- 🔄 Auto-reload files changed outside Neovim

	splitbelow = true, -- ➗ Horizontal splits go below
	splitright = true, -- ➗ Vertical splits go to the right

	completeopt = "menu,preview,noselect", -- 🍰 Completion menu settings:
	-- 🍥 'menu': Show completion options in a popup menu
	-- 🔍 'preview': Display a preview of the selected completion
	-- 🚫 'noselect': Don't automatically select the first completion item
	wildmenu = true, -- 🍥 Better command-line completion
	wildmode = "longest:full,full", -- 🍥 Command-line completion mode
}

for i, j in pairs(options) do
	vim.opt[i] = j
end
