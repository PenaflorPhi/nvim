vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Could be "■", "▶", etc.
		source = "if_many", -- Show source if there are multiple
	},
	float = {
		source = "always", -- Show the source of diagnostics in floating windows
	},
	signs = true,
	underline = true,
	update_in_insert = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
