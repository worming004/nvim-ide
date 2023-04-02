local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" })  -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs" })  -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "akinsho/bufferline.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "akinsho/toggleterm.nvim" })
  use({ "ahmedkhalf/project.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "goolord/alpha-nvim" })

  -- Colorschemes
  use({ "folke/tokyonight.nvim" })
  use({ "lunarvim/darkplus.nvim" })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" })         -- The completion plugin
  use({ "hrsh7th/cmp-buffer" })       -- buffer completions
  use({ "hrsh7th/cmp-path" })         -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })

  -- snippets
  use({ "L3MON4D3/LuaSnip" })             --snippet engine
  use({ "worming004/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({ "RRethy/vim-illuminate" })
  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    commit = "36c6826274ac85e04558e875a30e82aca676e3fe",
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- DAP
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui" })
  use({ "ravenxrz/DAPInstall.nvim" })

  use({ "tamton-aquib/keys.nvim" })

  use({ "vim-test/vim-test" })

  use({ "tpope/vim-fugitive" })

  use({
    "giusgad/pets.nvim",
    requires = {
      "edluffy/hologram.nvim",
      "MunifTanjim/nui.nvim",
    }
  })

  use { "j-hui/fidget.nvim" }

  use { "f-person/git-blame.nvim" }

  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim"
    },
    config = function()
      local navbuddy = require("nvim-navbuddy")
      navbuddy.setup({
        window = {
          border = "double",
          position = "90%"
        },
        lsp = { auto_attach = true }
      })
    end
  }

  use { "nvim-treesitter/nvim-treesitter-context" }

  use "b0o/schemastore.nvim"

  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
      require("which-key").setup {
      }
    end
  }

  use({
  'weilbith/nvim-code-action-menu',
  cmd = 'CodeActionMenu',
})
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
