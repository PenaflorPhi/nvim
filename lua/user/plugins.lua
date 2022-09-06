local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Packer 
  use "wbthomason/packer.nvim"

  -- Lua
  use "nvim-lua/plenary.nvim"   -- A collection of functions used by other plugins.
  use "nvim-lua/popup.nvim"     -- An implementation of the Popup API from vim in Neovim.
  use "christianchiarulli/lua-dev.nvim"

  -- Git
  use "lewis6991/gitsigns.nvim" -- Works
  use "f-person/git-blame.nvim" -- Works

  -- Terminal integration
  use "akinsho/toggleterm.nvim" -- Works

  -- cmp
  use "hrsh7th/nvim-cmp"  -- Works
  use "hrsh7th/cmp-nvim-lsp" -- Works
  use "hrsh7th/cmp-nvim-lua" -- ??
  use "hrsh7th/cmp-buffer" -- Works
  use "hrsh7th/cmp-path" -- Works
  use "hrsh7th/cmp-emoji"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-cmdline"  -- Not sure what this does.

  -- Snippets
  use "L3MON4D3/LuaSnip"  -- Works

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "mfussenegger/nvim-dap"
  use "mfussenegger/nvim-lint"
  use "mhartington/formatter.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "ray-x/lsp_signature.nvim"
  use "SmiteshP/nvim-navic"
  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  use "lvimuser/lsp-inlayhints.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use "windwp/nvim-ts-autotag"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "kylechui/nvim-surround"


  use "lukas-reineke/indent-blankline.nvim"
  -- use "yaocccc/nvim-hlchunk" -- Highlight indent lines in a very cool way, might try later.

  -- Comment
  use "numToStr/Comment.nvim"

  -- Editing Support
  use "windwp/nvim-autopairs"

  -- File Manager 
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  -- use "luukvbaal/nnn.nvim" -- Might try later

  -- Color
  use "NvChad/nvim-colorizer.lua"

  -- Colorscheme
  use "liuchengxu/space-vim-dark"
  -- use "folke/tokyonight.nvim"
  use "navarasu/onedark.nvim"
  use "lunarvim/darkplus.nvim"
  use "ray-x/aurora"
  use "sainnhe/gruvbox-material"
  use "Mofiqul/vscode.nvim"

  -- Markdown / LaTeX
  use {
    "iamcco/markdown-preview.nvim",
    opt = true,
    run = "cd app && npm install",
    ft  = "markdown",
    cmd = {'MarkdownPreview', 'MarkdownPreviewToggle'},
  }

  -- Statusline
  use "nvim-lualine/lualine.nvim"
  use "yamatsum/nvim-cursorline"
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

  --Statup
  use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }

  -- Motion
  use "phaazon/hop.nvim"
   
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
