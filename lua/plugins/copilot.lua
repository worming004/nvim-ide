return {
  'fang2hou/blink-copilot',
  lazy = true,
  dependencies = {
    {
      "zbirenbaum/copilot.lua",
      cmd = {
        "Copilot"
      },
      lazy = true,
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    },
    {
      'CopilotC-Nvim/CopilotChat.nvim',
      event = { 'BufEnter' },
      branch = "main",
      lazy = true,
      cmd = {
        "CopilotChat",
        "CopilotChatCommits",
        "CopilotChatDocs",
        "CopilotChatExplain",
        "CopilotChatFix",
        "CopilotChatLoad",
        "CopilotChatModels",
        "CopilotChatOpen",
        "CopilotChatOptimize",
        "CopilotChatPrompts",
        "CopilotChatReview",
        "CopilotChatTests",
        "CopilotChatToggle",
      }, -- Charger uniquement sur commande
      dependencies = {
        -- try without it and remove it new feature set is ok
        -- {
        --   'zbirenbaum/copilot.lua',
        --   lazy = true,
        --   opts = {
        --     suggestion = { enabled = false },
        --     panel = { enabled = false },
        --     filetypes = {
        --       markdown = true,
        --       yaml = true
        --     },
        --   }
        -- },
        { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
      },
      opts = {
        sticky = { '#buffer' },
        language = 'French',
        model = 'claude-sonnet-4.5',
        mappings = {
          reset = {
            normal = '',
            insert = '',
          },
        },
      },
      -- See Commands section for default commands if you want to lazy load on them
    }
  }
}
