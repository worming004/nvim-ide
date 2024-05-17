return {
"hrsh7th/nvim-cmp",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
    },
    {
      "hrsh7th/cmp-buffer",
    },
    {
      "hrsh7th/cmp-path",
    },
    {
      "hrsh7th/cmp-cmdline",
    },
    {
      "saadparwaiz1/cmp_luasnip",
    },
    {
      "hrsh7th/cmp-nvim-lsp-signature-help"
    },
	 {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      dependencies = {
        "worming004/friendly-snippets",
      },
    },
    {
      "hrsh7th/cmp-nvim-lua",
    },
    {
      "zbirenbaum/copilot-cmp",
      cmd = "Copilot",
      config = function()
        require("copilot_cmp").setup({
          fix_pairs = true,
        })
      end,
      dependencies = {
        {
          "CopilotC-Nvim/CopilotChat.nvim",
          branch = "canary",
          dependencies = {
            {
              "zbirenbaum/copilot.lua",
              opts = {
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = {
                  markdown = true,
                  yaml = true
                }
              }
            },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
          },
          opts = {
            debug = true, -- Enable debugging
            -- See Configuration section for rest
          },
          -- See Commands section for default commands if you want to lazy load on them
        },
      }
    }
	},
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
}

