return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local lint = require("lint")

			-- Autosave linters (fast, good signal)
			lint.linters_by_ft = {
				python = { "ruff" }, -- fast; style/errors; complement with mypy for types
				c = { "clangtidy" }, -- requires compile_commands.json
				cpp = { "clangtidy" },
				lua = { "luac", "luacheck" },
			}

			-- Optional heavy/secondary linters (manual trigger)
			-- They'll run in addition to the auto ones when you call :LintAllHeavy
			local heavy_by_ft = {
				python = { "pylint" },
				c = { "cppcheck" },
				cpp = { "cppcheck" },
			}

			-- Example: tweak args if you need (uncomment & adjust)
			-- lint.linters.cppcheck.args = { "--enable=warning,style,performance,portability", "--std=c11", "--template=gcc", "-" }
			-- Debounced runner to avoid thrashing
			local timer = vim.uv.new_timer()
			local function debounced_try_lint(bufnr, ms)
				timer:stop()
				timer:start(ms or 150, 0, function()
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "" then
							lint.try_lint() -- uses linters_by_ft
						end
					end)
				end)
			end

			-- Auto lint on save / when leaving insert
			local grp = vim.api.nvim_create_augroup("nvim-lint-autocmd", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
				group = grp,
				callback = function(args)
					debounced_try_lint(args.buf, 150)
				end,
			})

			-- Commands: on-demand heavy pass and quick pass
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
