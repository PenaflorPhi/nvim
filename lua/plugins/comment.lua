return {
	"numToStr/Comment.nvim",
	opts = {},
	config = function()
		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = {
				-- This keybinding should work as Ctrl + /
				line = "<C-_>",
			},
			opleader = {
				line = "<C-_>",
			},
			mappings = {
				basic = true,
				extra = true,
			},
			pre_hook = nil,
			post_hook = nil,
		})
	end,
}
