return {
  "nvim-neotest/neotest",
  lazy = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "jfpedroza/neotest-elixir",
    "Issafalcon/neotest-dotnet",
    {
      "fredrikaverpil/neotest-golang",
      dependencies = { "leoluz/nvim-dap-go" },
      opts = {
        dap_configurations = {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        }
      },
    },
    "nvim-neotest/neotest-jest"
  },
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}
  end,
  config = function(_, opts)
    require("neotest").setup({
      adapters = {
        require("neotest-elixir"),
        require("neotest-dotnet")({
          discovery_root = "solution",
          mix_task = { "test.interactive" }
        }),
        require("neotest-golang")({
          go_test_args = { "-count=1", "-timeout=60s" },
          -- dap_mode = "manual",
          -- dap_manual_config = {
          --   name = "Debug go tests",
          --   type = "go", -- Preconfigured DAP adapter name
          --   request = "launch",
          --   mode = "test",
          -- },
        }),
        require("neotest-jest")({
          jestCommand = "npm test --",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
}
