return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	opts = {
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		floating_window = true,
		hint_enable = false,
		doc_lines = 0,
		always_trigger = false,
		toggle_key = "<M-s>",
	},
}
