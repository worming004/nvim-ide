local M = {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/playground",
  },
}

function M.config()
  local configs = require "nvim-treesitter.configs"
  configs.setup {
    ensure_installed = {
      "bash",
      "c_sharp",
      "dockerfile",
      "elixir",
      "go",
      "gitignore",
      "html",
      "javascript",
      "json",
      "lua",
      "luap",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "sql",
      "svelte",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    }, 
    ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },

    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
  }
end

return M
