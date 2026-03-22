return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = "BufReadPost",
	keys = {
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "Close all folds",
		},
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "Open all folds",
		},
		{
			"zr",
			function()
				require("ufo").openFoldsExceptKinds()
			end,
			desc = "Open folds except kinds",
		},
		{
			"zm",
			function()
				require("ufo").closeFoldsWith()
			end,
			desc = "Close folds with",
		},
		{
			"zp",
			function()
				require("ufo").peekFoldedLinesUnderCursor()
			end,
			desc = "Peek fold",
		},
		{ "<leader>z", "za", desc = "Toggle fold" },
		{ "<leader>Z", "zR", desc = "Open all folds" }, -- quick escape hatch
		{
			"<leader>fo",
			function()
				local ufo = require("ufo")
				local level = vim.fn.foldlevel(vim.fn.line("."))
				if level == 0 then
					return
				end
				ufo.closeFoldsWith(level - 1)
			end,
			desc = "Open fold at cursor level",
		},
	},
	init = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	config = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  ↙ %d lines"):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						table.insert(newVirtText, { chunkText, chunk[2] })
						chunkWidth = targetWidth - curWidth
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		})
		vim.api.nvim_create_autocmd("BufReadPost", {
			callback = function()
				require("ufo").closeAllFolds()
			end,
		})
	end,
}
