return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
      config = function()
        require("mcphub").setup({
          extension = {
            copilotchat = {
              enabled = true,
              convert_tools_to_functions = true,     -- Convert MCP tools to CopilotChat functions
              convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
              add_mcp_prefix = false,
            }
          }
        })
      end,
      init = function()
        if vim.env.ENABLE_MCPHUB == "1" or vim.env.ENABLE_MCPHUB == "true" then
          vim.schedule(function()
            require("lazy").load({ plugins = { "mcphub.nvim" } })
          end)
        end
      end

    }
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
                  default = "Qwen3-Coder-30B-A3B-Instruct-GGUF",
                  choices = { "Qwen3-Coder-30B-A3B-Instruct-GGUF", { "openai/open-oss-120b", opts = { can_reason = true } } }
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
      strategies = {
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
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true
          }
        }
      }
    })
  end,

  keys = {
    { "<leader>a",  "",                                  desc = "AI",                      mode = { "n", "v" } },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Open CodeCompanion Chat", mode = "n" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>",            desc = "Inline CodeCompanion",    mode = "n" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>",     desc = "CodeCompanion Actions",   mode = "n" },
  },
}
