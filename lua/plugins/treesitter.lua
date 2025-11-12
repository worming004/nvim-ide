return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = function()
    vim.system({ "npm", "install", "-g", " tree-sitter-cli" }):wait()
    require("nvim-treesitter").install({
      "bash",
      "bicep",
      "c_sharp",
      "dockerfile",
      "elixir",
      "erlang",
      "go",
      "gomod",
      "gosum",
      "gleam",
      "gitignore",
      "graphql",
      "heex",
      "html",
      "htmldjango",
      "http",
      "ini",
      "java",
      "javascript",
      "jq",
      "json",
      "lua",
      "luap",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "rego",
      "ruby",
      "rust",
      "scss",
      "sql",
      "svelte",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "vhs",
      "yaml",
      "zig"
    })
  end,
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
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
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "VeryLazy",
    },
    {
      "windwp/nvim-ts-autotag",
      opts = {},
    },
  },
}
