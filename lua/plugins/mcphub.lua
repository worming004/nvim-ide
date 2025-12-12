return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",
  config = function()
    require("mcphub").setup({
      -- Configuration du serveur MCP
      servers = {
        -- Exemple : serveur filesystem
        -- filesystem = {
        --   command = "npx",
        --   args = { "-y", "@modelcontextprotocol/server-filesystem", "/path/to/allowed/directory" },
        --   env = {},
        -- },
      },

      -- Options d'interface
      ui = {
        -- Position de la fenêtre : 'center', 'top', 'bottom', 'left', 'right'
        position = "center",
        -- Taille de la fenêtre (pourcentage ou valeur absolue)
        size = {
          width = 0.8,
          height = 0.8,
        },
        -- Bordure de la fenêtre
        border = "rounded", -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
      },

      -- Options de logging
      log = {
        level = "info", -- 'trace', 'debug', 'info', 'warn', 'error'
      },
    })
  end,
}
