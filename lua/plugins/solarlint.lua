return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
  event = "BufReadPre",

  config = function()
    local lspconfig = require "lspconfig"
    require('sonarlint').setup({
      server = {
        cmd = {
          '$HOME/.local/share/nvim/mason/bin/sonarlint-language-server',
          '-stdio',
          '-analyzers',
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarlintomnisharp.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonargo.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
        }
      },
      filetypes = {
        -- Tested and working
        'go',
        'golang',
        'cs',
        'html',
        'python'
      }
    })
  end,
  -- enabled = false
}
