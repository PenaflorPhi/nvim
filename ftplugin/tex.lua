local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local opts_ctrl = {
	mode = "n", -- NORMAL mode
	-- prefix = "<CTRL>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	k = { "<cmd>!TexCompile.sh -Z > /dev/null <CR>", "PDF" },
	r = {
		name = "LaTeX",
		b = { "<cmd>!TexCompile.sh -B > /dev/null <CR>", "Bibliography" },
		B = { "<cmd>!TexCompile.sh -B -Z > /dev/null <CR>", "Bib + PDF" },
		l = { "<cmd>!TexCompile.sh -L > /dev/null <CR>", "LuaLaTeX" },
		L = { "<cmd>!TexCompile.sh -L -Z > /dev/null <CR>", "LuaLaTeX + PDF" },
		p = { "<cmd>!TexCompile.sh -P > /dev/null <CR>", "pdfLaTeX" },
		P = { "<cmd>!TexCompile.sh -P > /dev/null <CR>", "pdfLaTeX + PDF" },
		x = { "<cmd>!TexCompile.sh -X > /dev/null <CR>", "XeLaTeX" },
		X = { "<cmd>!TexCompile.sh -X -Z > /dev/null <CR>", "XeLaTeX + PDF" },
		r = { "<cmd>!TexCompile.sh > /dev/null <CR>", "Compile" },
		e = { ":w syntax spell toplevel<CR>", "Spell" },
	},
}

local mappings_ctrl = {
	["<C-k>"] = { "<cmd>!TexCompile.sh -Z > /dev/null <CR>", "PDF" },
	["<C-l>"] = { "<cmd>!TexCompile.sh > /dev/null <CR>", "Compile" },
}
which_key.register(mappings, opts)
which_key.register(mappings_ctrl, opts_ctrl)
