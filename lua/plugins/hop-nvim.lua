return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function(_, opts)
		local hop = require("hop")
		hop.setup(opts)

		vim.keymap.set("", "<S-s>", function()
			hop.hint_words()
		end, { remap = true })
	end,
}
