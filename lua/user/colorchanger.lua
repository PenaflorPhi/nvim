-- local status_ok, which_key = pcall(require, "which-key")
-- if not status_ok then
-- 	return
-- end

-- local color_list = "getcompletion('', 'color')"

vim.cmd[[
let g:colors = getcompletion('', 'color')
func! NextColors()
    let idx = index(g:colors, g:colors_name)
    return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
endfunc
func! PrevColors()
    let idx = index(g:colors, g:colors_name)
    return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
endfunc
nnoremap <Space>- :exe "colo " .. PrevColors()<cr>
nnoremap <Space>+ :exe "colo " .. NextColors()<cr>
]]

-- local opts_alt = {
-- 	mode = "n", -- NORMAL mode
-- 	-- prefix = "<alt>",
-- 	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
-- 	silent = true, -- use `silent` when creating keymaps
-- 	noremap = true, -- use `noremap` when creating keymaps
-- 	nowait = true, -- use `nowait` when creating keymaps
-- }

-- local mappings_alt = {
-- 	["<C-1>"] = { ":lua print(1)<CR>", "colorschemes" },
-- }

-- which_key.register(mappings_alt, opts_alt)
