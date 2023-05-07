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
  },
}

function M.config()
  vim.g["test#strategy"] = "tmuxify"
end

return M
