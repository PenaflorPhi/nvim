local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl_shortcut = "Macro"
  return b
end

local icons = require "user.icons"

dashboard.section.header.val = {
[[      :?PB&&?     .!YG###BPJ~.     ]],
[[    ^5&@@@@@J    !B@&5??JP@@@#J.   ]],
[[   ?&@@@@&GY.   J@@5.     ^G@@@#!  ]],
[[  5@@@@#?:     ~@@P        .B@@@@7 ]],
[[ 5@@@@P.       G@@^         7@@@@&:]],
[[7@@@@G        :&@B          ^@@@@@7]],
[[G@@@@~        ~@@P          ~@@@@@?]],
[[B@@@&:        !@@5          5@@@@@^]],
[[Y@@@@:        !@@5         !@@@@@5 ]],
[[.B@@@5        ~@@P        7@@@@@5  ]],
[[ :P@@@5:      ^@@G      ~G@@@@B!   ]],
[[   ~5#@@P7^.  :@@G  :!Y#@@@#5!     ]],
[[     .~?PB#BBGB@@&GB#&#G5?^.       ]],
[[          .:^^5@@#!^:.             ]],
[[              P@@&:                ]],
[[             :&@@@7                ]],
[[             ?@@@@P                ]],
[[             5@@@@B                ]],
[[             !&@@@Y                ]],
}
dashboard.section.buttons.val = {
  button("n", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
  button("f", icons.documents.Files .. " Find file", ":Telescope find_files <CR>"),
  button("g", icons.ui.List .. " Find text", ":Telescope live_grep <CR>"),
  button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
  button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
}
local function footer()
  -- NOTE: requires the fortune-mod package to work
  -- local handle = io.popen("fortune")
  -- local fortune = handle:read("*a")
  -- handle:close()
  -- return fortune
  return "PenaflorPhi"
end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Macro"
dashboard.section.footer.opts.hl = "Type"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
