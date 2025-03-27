return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    {
      {
        "zbirenbaum/copilot.lua",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            yaml = true
          },
        }
      }
    },
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  opts = {
    debug = true,      -- Enable debugging
    context = "files", -- Default context or array of contexts to use (can be specified manually in prompt via #).
    mappings = {
      reset = {
        normal = '',
        insert = '',
      },
    },
  },
  -- See Commands section for default commands if you want to lazy load on them
}
