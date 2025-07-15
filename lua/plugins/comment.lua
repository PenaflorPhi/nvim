return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	config = function()
		local comment = require("Comment")

		comment.setup({
			padding = true,
			sticky = true,
			--- Disable all default keybindings
			mappings = {
				basic = false,
				extra = false,
			},
		})

		--- Custom keymap for toggling line comment in NORMAL and VISUAL mode
		local map = vim.keymap.set
		map("n", "<leader>/", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle comment", noremap = true })

		map("v", "<leader>/", function()
			local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
			vim.api.nvim_feedkeys(esc, "nx", false)
			require("Comment.api").toggle.linewise(vim.fn.visualmode())
		end, { desc = "Toggle comment (visual)", noremap = true })
	end,
}
