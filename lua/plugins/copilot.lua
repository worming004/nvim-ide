return {
  "CopilotC-Nvim/CopilotChat.nvim",
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
  },                             -- Charger uniquement sur commande
  dependencies = {
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  opts = {
    sticky = { '#buffer' },
    language = 'French',
    model = 'claude-sonnet-4.5',
    mappings = {
      reset = {
        normal = '', -- empty to not reset by accident
        insert = '',
      },
    },
  },
  -- See Commands section for default commands if you want to lazy load on them
}
