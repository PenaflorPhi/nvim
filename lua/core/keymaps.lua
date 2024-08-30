local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Key mappings for general functions
--===================================|
-- File Explorer                     |
--===================================|
-- vim.api.nvim_set_keymap("n", "<leader>e", ":Explore<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

--===================================|
-- Windows                           |
--===================================|
-- Window navigation
vim.api.nvim_set_keymap("n", "<S-Left>", "0", opts)
vim.api.nvim_set_keymap("n", "<S-Right>", "$", opts)

-- Switch between windows
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>l", opts)

--===================================|
-- Buffers                           |
--===================================|
-- Buffer navigation
vim.api.nvim_set_keymap("n", "<A-Left>", ":bprev<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-Right>", ":bnext<CR>", opts)

-- Opening and Closing buffers
vim.api.nvim_set_keymap("n", "<leader>n", ":vnew<CR>", opts) -- Create a new buffer
vim.api.nvim_set_keymap("n", "<leader>c", ":bd<CR>", opts) -- Delete current buffer

--===================================|
-- Text Editing                      |
--===================================|
-- Deleting text
vim.api.nvim_set_keymap("i", "<C-BS>", "<Esc>bDa", opts) -- Insert mode
vim.api.nvim_set_keymap("n", "<C-BS>", "bD", opts) -- Normal mode

-- Align text and folds
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", opts)
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", opts)
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)
vim.api.nvim_set_keymap("v", "z", ":fold<CR>", opts)

-- Additional commands
vim.api.nvim_set_keymap("n", "<C-d>", "ggVGd", opts) -- Delete all lines
vim.api.nvim_set_keymap("n", "<A-/>", ":nohlsearch<CR>", opts) -- Clear search highlights
vim.api.nvim_set_keymap("n", "<leader>f", ":Format<CR>", opts) -- Format code

--===================================|
-- Dictionary and Spelling           |
--===================================|
vim.api.nvim_set_keymap("n", "<A-n>", "]s", opts) -- Next misspelled word
vim.api.nvim_set_keymap("n", "<A-s>", "z=", opts) -- Show suggestions
vim.api.nvim_set_keymap("n", "<A-a>", "zg", opts) -- Add to dictionary
vim.api.nvim_set_keymap("n", "<A-u>", "zug", opts) -- Undo add to dictionary

--===================================|
-- Hop                               |
--===================================|
vim.api.nvim_set_keymap("n", "s", ":HopChar2<CR>", opts) -- Hop to character
vim.api.nvim_set_keymap("n", "<S-s>", ":HopWord<CR>", opts) -- Hop to word

--===================================|
-- Miscellaneous                     |
--===================================|
vim.api.nvim_set_keymap("n", "<leader>m", ":MarkdownPreviewToggle<CR>", opts)
-- Define the command to spawn a terminal in the current file's directory
vim.api.nvim_set_keymap("n", "<leader>s", ":lua spawn_terminal()<CR>", opts)

-- Function to spawn an external terminal in the current file's directory
function spawn_terminal()
	local file_dir = vim.fn.expand("%:p:h") -- Get current file's directory
	-- Command to spawn an external terminal (adjust for your terminal)
	vim.fn.jobstart({ "x-terminal-emulator", "-e", "bash", "-c", "cd '" .. file_dir .. "' && exec bash" })
end
