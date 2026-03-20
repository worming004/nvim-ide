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
        }
      },
      adapters = {
        http = {
          lmstudio = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "lmstudio",
              env = {
                url = "http://localhost:1234",
                api_key = "lmstudio",
              },
              schema = {
                model = {
                  default = "qwen/qwen3-coder-next",
                  choices = {
                    { "qwen/qwen3-coder-next",             opts = { can_reason = true } },
                    { "Qwen3-Coder-30B-A3B-Instruct-GGUF", opts = { can_reason = true } },
                    { "openai/open-oss-120b",              opts = { can_reason = true } },
                  }
                },
              },
            })
          end,
          remote = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "lmstudio",
              env = {
                url = "http://192.168.129.3:1234",
                api_key = "lmstudio",
              },
              schema = {
                model = {
                  default = "Qwen3-Coder-30B-A3B-Instruct-GGUF",
                  choices = { "Qwen3-Coder-30B-A3B-Instruct-GGUF", { "openai/open-oss-120b", opts = { can_reason = true } } }
                },
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
