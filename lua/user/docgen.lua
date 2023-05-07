return {
  "danymat/neogen",
  keys = {
    {
      "<leader>cc",
      function()
        require("neogen").generate {}
      end,
      desc = "Neogen Comment",
    },
  },
  opts = { snippet_engine = "luasnip" },
  cmd = { "Neogen" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
