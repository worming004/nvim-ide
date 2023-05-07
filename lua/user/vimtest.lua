local M = {
  "vim-test/vim-test",
  cmd = {
    "TestClass",
    "TestFile",
    "TestLast",
    "TestNearest",
    "TestSuite",
    "TestVisit",
  },
  dependencies = {
    "jebaum/vim-tmuxify",
    event = "VeryLazy",
  },
}

function M.config()
  vim.g["test#strategy"] = "Tmuxify"
end

return M
