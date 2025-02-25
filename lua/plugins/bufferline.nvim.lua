return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				show_buffer_close_icons = false,
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true, -- use a "true" to enable the default, or set your own character
					},
				},
				highlights = {
					fill = {
						bg = {
							attribute = "fg",
							highlight = "Pmenu",
						},
					},
				},
			},
		})
	end,
}
