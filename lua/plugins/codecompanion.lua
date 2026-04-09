return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "zbirenbaum/copilot.lua",
      config = function()
        require("copilot").setup({})
      end
    },
  },
  lazy = true,
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  config = function()
    local defaultAdapter = "lmstudio"

    require("codecompanion").setup({
      mcp = {
        servers = {
          ["sequential-thinking"] = {
            cmd = { "npx", "-y", "@modelcontextprotocol/server-sequential-thinking" },
          },
          ["tavily-mcp"] = {
            cmd = { "npx", "-y", "tavily-mcp@latest" },
          },
        },
        -- opts = {
        --   default_servers = { "sequential-thinking", "tavily-mcp" },
        -- },
      },
      adapters = {
        http = {
          remote = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "remote",
              env = {
                url = "http://192.168.129.3:1234",
              },
            })
          end,
          copilot = "copilot"
        },
      },
      interactions = {
        chat = {
          adapter = defaultAdapter,
        },
        inline = {
          adapter = defaultAdapter,
        },
        agent = {
          adapter = defaultAdapter,
        },
      },
    })
  end,
}
