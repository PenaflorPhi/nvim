-- Neovim configuration options
local options = {
    -- ===== UI =====
    number = true,
    relativenumber = true,
    numberwidth = 4,
    signcolumn = "yes",
    cursorline = true,
    colorcolumn = "88",
    termguicolors = true,     -- Enable 24-bit RGB colors
    background = "dark",

    -- ===== Indentation & Text Formatting =====
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    smartindent = true,
    linebreak = true,
    wrap = true,

    -- ===== Search =====
    hlsearch = true,
    incsearch = true,
    ignorecase = true,
    smartcase = true,

    -- ===== Splits & Windows =====
    splitbelow = true,        -- Horizontal splits open below
    splitright = true,        -- Vertical splits open to the right

    -- ===== Completion & Command Line =====
    -- completeopt:
    --  menu      : show popup menu when there are matches
    --  menuone   : show the menu even if there’s only one match
    --  noselect  : don’t preselect; confirm with <CR>/<Tab>
    --  preview   : show a preview window (often noisy; usually omit)

    -- To trigger native completion:
    --  <C-n>/<C-p>   : word completion from buffers
    --  <C-x><C-o>    : omni completion (language-aware)
    --  <C-x><C-f>    : file path completion
    --  <C-x><s>      : spelling suggestions
    completeopt = { "menuone", "noselect" },
    pumheight = 10,
    wildmenu = true,
    wildmode = "longest:full,full",

    -- ===== Performance & Responsiveness =====
    updatetime = 50,          -- Time in ms for CursorHold event (affects LSP responsiveness)
    timeoutlen = 150,         -- Timeout for mapped key sequences (in ms)
    scrolloff = 8,            -- Keep 8 lines visible above/below the cursor
    sidescroll = 8,           -- Horizontal scroll by 8 columns

    -- ===== Files =====
    fileencoding = "utf-8",   -- Default file encoding
    autoread = true,          -- Auto-reload files changed outside of Neovim
    swapfile = false,         -- Don’t use swapfiles
    backup = false,           -- Don’t keep backup files
    undofile = true,          -- Enable persistent undo across sessions
    clipboard = "unnamedplus",-- Use system clipboard for all operations

    -- ===== UI Behavior =====
    cmdheight = 1,            -- Height of the command line (1 = default)
    laststatus = 2,           -- Always show the status line
    showmode = true,          -- Show the current mode (INSERT, etc.)
    showtabline = 2,          -- Always show the tabline

    -- ===== Spell Checking =====
    spell = true,
    spelllang = { "en", "es" },
    spellsuggest = "10",
}

-- Apply options
for k, v in pairs(options) do
    vim.opt[k] = v
end


-- == Check Health
-- Ignore Providers
vim.g.loaded_perl_provider  = 0
vim.g.loaded_ruby_provider  = 0

-- Use host's interpreter
vim.g.python3_host_prog = "/usr/bin/python3"
