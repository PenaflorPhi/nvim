return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("mason").setup()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"go",
				"html",
				"javascript",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"rust",
				"vim",
				"vimdoc",
				"python",
				"sql",
			},

			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
