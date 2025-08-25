return {
    { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate",
        opts = {
            -- A list of parser names, or "all"
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",

                -- your “required”
                "asm",
                "bash",
                "comment",
                "cpp",
                "css",
                "html",
                "javascript",
                "dockerfile",
                "fish",
                "go",
                "python",
                "sql",
            },

            -- Install missing parsers automatically on buffer enter
            auto_install = true,

            -- Skip parsers you never want
            -- ignore_install = { "javascript" },

            highlight = {
                enable = true,
                -- Single function that supports both fixed blacklist and large-file cutoff
                disable = function(lang, buf)
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

            -- Optional: TS-based indentation (often disable for python)
            indent = { enable = true, disable = { "python" } },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}

