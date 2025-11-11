return {
  "nvim-neotest/neotest",
  lazy = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "jfpedroza/neotest-elixir",
    "Issafalcon/neotest-dotnet",
    {
      "fredrikaverpil/neotest-golang",
      version = "*",                                                            -- Optional, but recommended; track releases
      build = function()
        vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
      end,
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      }
    },
    "nvim-neotest/neotest-jest"
  },
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}
  end,
  config = function(_, _opts)
    require("neotest").setup({
      adapters = {
        require("neotest-elixir"),
        require("neotest-dotnet")({
          discovery_root = "solution",
          mix_task = { "test.interactive" }
        }),
        require("neotest-golang")({
          -- go_test_args = { "-count=1", "-timeout=60s" },
          -- runner = "gotestsum"
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
