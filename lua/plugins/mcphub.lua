return {
  "ravitemer/mcphub.nvim",
  lazy = true, -- Load this plugin with :McpHubLoad
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
