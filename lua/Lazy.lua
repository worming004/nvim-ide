local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup("user", {
  install = { colorscheme = { require("user.colorscheme").name } },
  defaults = { lazy = true, version = "*" },
  ui = { wrap = "true" },
  change_detection = { enabled = true, notify = false },
  checker = { enabled = false },
  debug = false,
  performance = {
    rtp = {
      disabled_plugins = {
        -- "gzip", -- Plugin for editing compressed files.
        -- "matchit", -- What is it?
        -- "matchparen", -- Plugin for showing matching parens
        -- "netrwPlugin", -- Handles file transfers and remote directory listing across a network
        -- "tarPlugin", -- Plugin for browsing tar files
        -- "tohtml", -- Converting a syntax highlighted file to HTML
        -- "tutor", -- Teaching?
        -- "zipPlugin", -- Handles browsing zipfiles
      },
    },
  },
})
