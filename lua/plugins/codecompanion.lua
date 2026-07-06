return
{
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = 'qwen',
        inline = 'qwen',
      },
    },
    adapters = {
      qwen = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'qwen',   -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = 'qwen2.5-coder:7b',
            },
          },
        })
      end,
    },
    opts = {
      log_level = 'DEBUG',
    },
    display = {
      diff = {
        enabled = true,
        close_chat_at = 240,    -- Close an open chat buffer if the total columns of your display are less than...
        layout = 'vertical',    -- vertical|horizontal split for default provider
        opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
        provider = 'default',   -- default|mini_diff
      },
    },
  },
}
-- return {
--   "olimorris/codecompanion.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--     {
--       "zbirenbaum/copilot.lua",
--       config = function()
--         require("copilot").setup({})
--       end
--     },
--   },
--   lazy = true,
--   cmd = {
--     "CodeCompanion",
--     "CodeCompanionActions",
--     "CodeCompanionChat",
--     "CodeCompanionCmd",
--   },
--   config = function()
--     local defaultAdapter = "remote"
--
--     require("codecompanion").setup({
--       adapters = {
--         http = {
--           opts = {
--             show_model_choices = true,
--           },
--           remote = function()
--             return require("codecompanion.adapters").extend("openai_compatible", {
--               name = "remote",
--               env = {
--                 url = "http://192.168.129.3:11434",
--               },
--             })
--           end,
--         },
--       },
--       interactions = {
--         chat = {
--           adapter = defaultAdapter,
--         },
--         inline = {
--           adapter = defaultAdapter,
--         },
--         agent = {
--           adapter = defaultAdapter,
--         },
--       },
--     }
--     )
--   end,
-- }
