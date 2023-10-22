local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/playground",
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
        local opts = require("lazy.core.plugin").values(plugin, "opts", false)
        local enabled = false
        if opts.textobjects then
          for _, mod in ipairs { "move", "select", "swap", "lsp_interop" } do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              enabled = true
              break
            end
          end
        end
        if not enabled then
          require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
        end
      end,
    },
  },
}

function M.config()
  local configs = require "nvim-treesitter.configs"
  configs.setup {
    ensure_installed = {
      "bash",
      "bicep",
      "c_sharp",
      "dockerfile",
      "elixir",
      "go",
      "gitignore",
      "heex",
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
    sync_install = false,    -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true,       -- false will disable the whole extension
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
      updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
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
