return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
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
                },
              },
            })
          end,
          copilot = "copilot"
        },
      },
      strategies = {
        chat = {
          adapter = "lmstudio",
        },
        inline = {
          adapter = "lmstudio",
        },
        agent = {
          adapter = "lmstudio",
        },
      },
    })
  end,

  keys = {
    { "<leader>a",  "",                                  desc = "AI",                      mode = { "n", "v" } },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Open CodeCompanion Chat", mode = "n" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>",            desc = "Inline CodeCompanion",    mode = "n" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>",     desc = "CodeCompanion Actions",   mode = "n" },
  },
}
