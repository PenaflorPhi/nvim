return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local lint = require("lint")

			-- Fix Mason path for luacheck
			lint.linters.luacheck = vim.tbl_deep_extend("force", lint.linters.luacheck, {
				cmd = vim.fn.stdpath("data") .. "/mason/bin/luacheck",
			})

			lint.linters_by_ft = {
				python = { "ruff" },
				c = { "clangtidy" },
				cpp = { "clangtidy" },
				lua = { "luac", "luacheck" },
				cmake = { "cmakelint" },
			}

			local heavy_by_ft = {
				python = { "pylint" },
				c = { "cppcheck" },
				cpp = { "cppcheck" },
			}

			local timer = vim.uv.new_timer()
			local function debounced_try_lint(bufnr, ms)
				timer:stop()
				timer:start(ms or 150, 0, function()
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "" then
							lint.try_lint()
						end
					end)
				end)
			end

			local grp = vim.api.nvim_create_augroup("nvim-lint-autocmd", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
				group = grp,
				callback = function(args)
					debounced_try_lint(args.buf, 150)
				end,
			})

			vim.api.nvim_create_user_command("LintNow", function()
				lint.try_lint()
			end, {})

			vim.api.nvim_create_user_command("LintAllHeavy", function()
				local ft = vim.bo.filetype
				local list = heavy_by_ft[ft]
				if list and #list > 0 then
					lint.try_lint(list)
				end
			end, {})
		end,
	},
}
