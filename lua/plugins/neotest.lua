return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "jfpedroza/neotest-elixir",
    "Issafalcon/neotest-dotnet",
    "nvim-neotest/neotest-go"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-elixir"),
        require("neotest-dotnet")({
          discovery_root = "solution"
        }),
        require("neotest-go")({
          recursive_run = true
        })
      },
    })
  end,
}
