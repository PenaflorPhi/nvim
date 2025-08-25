-- Helper for keymaps with defaults
local default_opts = { noremap = true, silent = true }
local function map(mode, lhs, rhs, desc, opts)
    local o = opts and vim.tbl_extend("force", default_opts, opts) or default_opts
    if desc then o.desc = desc end
    vim.keymap.set(mode, lhs, rhs, o)
end

return {
    -- 🌳 Core Treesitter: parsing, highlighting, indentation
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate", -- auto-update parsers
        opts = {
            ensure_installed = {
                "c","lua","vim","vimdoc","query","markdown","markdown_inline",
                "asm","bash","comment","cpp","css","html","javascript",
                "dockerfile","fish","go","python","sql",
            },
            auto_install = true, -- install missing parsers automatically
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    -- disable highlighting for certain langs or very large files
                    local blacklist = { c = true, rust = true }
                    if blacklist[lang] then return true end

                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                    return false
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true, disable = { "python" } },
            refactor = {
                highlight_definitions = { enable = true, clear_on_cursor_move = true },
                smart_rename = { enable = true, keymaps = { smart_rename = false } },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- ✏️ Treesitter Refactor: definitions, smart rename, etc.
    {
        "nvim-treesitter/nvim-treesitter-refactor",
        config = function()
            -- Custom Smart Rename keymap
            map("n", "<leader>r", function()
                require("nvim-treesitter-refactor.smart_rename").smart_rename()
            end, "Smart Rename with TreeSitter refactor")
        end,
    },

    -- 📌 Treesitter Context: sticky context window at the top of the editor
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
            multiwindow = false,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = "outer",
            mode = "cursor",
            separator = nil,
            zindex = 20,
            on_attach = nil,
        },
        config = function(_, opts)
            require("treesitter-context").setup(opts)
        end,
    },

}

