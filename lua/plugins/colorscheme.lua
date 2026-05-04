return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.blue, bold = true },
        }
      end,
    })
    vim.cmd("colorscheme catppuccin")
  end
}
