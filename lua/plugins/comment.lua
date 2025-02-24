return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      -- Disable default mappings so you can use your own
      mapping = {
        basic = false,
        extra = false,
      },
      toggler = {
        line = "<C-/>",  -- this will toggle line comments using Ctrl-/
      },
    })
    -- Optionally, you can explicitly set the mapping for visual mode too:
    vim.keymap.set("n", "<C-/>", function()
      require("Comment.api").toggle.linewise.current()
    end, { noremap = true, silent = true })
    vim.keymap.set("v", "<C-/>", function()
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end, { noremap = true, silent = true })
  end,
}
