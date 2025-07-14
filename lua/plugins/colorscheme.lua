local theme = os.getenv("NVIM_THEME") or "tokyonight"

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if theme == "tokyonight" then
        vim.cmd([[colorscheme tokyonight-night]])
      end
    end,
  },

  {
    "tiagovla/tokyodark.nvim",
    priority = 1000,
    config = function()
      if theme == "tokyodark" then
        require("tokyodark").setup()
        vim.cmd([[colorscheme tokyodark]])
      end
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      if theme == "kanagawa" then
        require("kanagawa").setup({
          theme = "wave",
          background = { dark = "wave", light = "lotus" },
        })
        vim.cmd([[colorscheme kanagawa]])
      end
    end,
  },
}
