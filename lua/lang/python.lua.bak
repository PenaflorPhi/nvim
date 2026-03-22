-- Root finder: looks for project markers upward from the file
local function find_root(fname)
	local markers = { "pyproject.toml", "pyrightconfig.json", ".git" }
	local found = vim.fs.find(markers, { path = fname, upward = true })[1]
	return found and vim.fs.dirname(found) or vim.loop.cwd()
end

-- Start Pyright per Python buffer if not already attached
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function(args)
		local buf = args.buf
		local fname = vim.api.nvim_buf_get_name(buf)
		local root = find_root(fname)

		-- avoid duplicate clients in the same root
		for _, client in pairs(vim.lsp.get_active_clients({ name = "pyright" })) do
			if client.config.root_dir == root then
				return
			end
		end

		vim.lsp.start({
			name = "pyright",
			cmd = { "pyright-langserver", "--stdio" },
			root_dir = root,
			capabilities = vim.lsp.protocol.make_client_capabilities(),
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic",
					},
				},
			},
		})
	end,
})
