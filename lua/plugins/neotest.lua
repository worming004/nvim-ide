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
      config = function()
        require("dap-go").setup(
          {
            dap_configurations = {
              type = "go",
              name = "Attach remote",
              mode = "remote",
              request = "attach",
            },
          })
      end,
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
