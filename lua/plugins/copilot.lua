return {
  "CopilotC-Nvim/CopilotChat.nvim",
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
    {
      {
        "zbirenbaum/copilot.lua",
        config = function()
          require("copilot").setup({})
        end,
      }
    },
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {
    language = 'French',
    model = 'claude-sonnet-4.5',
    mappings = {
      reset = {
        normal = '', -- empty to not reset by accident
        insert = '',
      },
    },
  },
}
