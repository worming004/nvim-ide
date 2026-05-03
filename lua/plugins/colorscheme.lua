return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  config = function()
    local transparent = vim.env.KITTY_WINDOW_ID ~= nil
    require("catppuccin").setup({
      transparent_background = transparent,
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.blue, bold = true },
        }
      end,
    })
    vim.cmd("colorscheme catppuccin")
  end
}
