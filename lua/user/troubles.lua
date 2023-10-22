return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("trouble").setup {}
  end,
  opts = { use_diagnostic_signs = true },
  cmd = { "TroubleToggle", "Trouble" },
}
