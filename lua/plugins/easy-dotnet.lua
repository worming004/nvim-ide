return
{
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
  config = function()
    require("easy-dotnet").setup({
      notifications = { handler = function(start_event) end },
      lsp = { enabled = false, }
    })
  end
}
