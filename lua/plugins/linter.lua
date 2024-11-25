return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      go = { "golangcilint" },
      zsh = { "zsh" },
    }

    lint.linters.golangcilint.args = {
      'run',
      '--out-format',
      'json',
      '--show-stats=false',
      '--print-issued-lines=false',
      -- '--print-linter-name=false',
      '--config=~/.config/nvim/linters/golangci-lint.yml',
      function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
      end
    }
  end,
}
