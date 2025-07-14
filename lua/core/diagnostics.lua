vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Could be "■", "▶", etc.
		source = "if_many", -- Show source if there are multiple
	},
	float = {
		source = "always", -- Always show the diagnostic source in floating windows
	},
	signs = {
		active = {
			{ name = "DiagnosticSignError", text = " " },
			{ name = "DiagnosticSignWarn", text = " " },
			{ name = "DiagnosticSignHint", text = " " },
			{ name = "DiagnosticSignInfo", text = " " },
		},
	},
	underline = true,
	update_in_insert = false,
})
