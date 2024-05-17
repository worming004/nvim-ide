local function lsp_keymaps(buffer_number)
  local default_config = { noremap = true, silent = true }
  local normal_default_buffer = function(sequences, command, opt_extend)
    opt_extend = opt_extend or {}
    local overrided_opts = vim.tbl_deep_extend("force", default_config, opt_extend)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", sequences, command, overrided_opts)
  end
  normal_default_buffer("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  normal_default_buffer("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  normal_default_buffer("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  normal_default_buffer("gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
  normal_default_buffer("<leader>lgr", "<cmd>lua vim.lsp.buf.references()<CR>")
  normal_default_buffer("<leader>lla", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  normal_default_buffer("<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>")
  normal_default_buffer("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>")
  normal_default_buffer("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>")
  normal_default_buffer("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  normal_default_buffer("<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
  normal_default_buffer("<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
  normal_default_buffer("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  normal_default_buffer("<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
  normal_default_buffer("<C-U>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  vim.notify("loaded keymap")
end

local M = {
  "neovim/nvim-lspconfig",
  branch = "master",
  event = "BufReadPre",
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      "hrsh7th/cmp-nvim-lsp",
      {
        "williamboman/mason.nvim",
        event = "BufReadPre",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
      },
      "Hoffs/omnisharp-extended-lsp.nvim",
      "barreiroleo/ltex_extra.nvim"
    },
    {
      "VidocqH/lsp-lens.nvim",
      lazy = false,
      opts = {}
    },
    {
      "nvimdev/lspsaga.nvim",
      event = "LspAttach",
      config = function()
        require("lspsaga").setup {
          finder = {
            layout = "normal"
          }
        }
      end,
      dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" },
      },
    },
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        local navbuddy = require "nvim-navbuddy"
        navbuddy.setup {
          window = {
            border = "double",
            position = "90%",
          },
          lsp = { auto_attach = true },
        }
      end,
      cmd = "Navbuddy",
    },
    { "folke/neodev.nvim", opts = {} },
  },
}


function M.config()
  local cmp_nvim_lsp = require "cmp_nvim_lsp"
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- not sure what this is doing
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)


  -- https://www.reddit.com/r/neovim/comments/y9qv1w/autoformatting_on_save_with_vimlspbufformat_and/
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local custom_on_attach = function(client, buffer_number)
    -- autoformat
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = buffer_number }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = buffer_number,
        callback = function()
          if vim.g.autoformat then
            vim.lsp.buf.format()
          else
            vim.notify("Autoformat deactivated")
          end
        end,
      })
    end

    lsp_keymaps(buffer_number)
  end

  for _, server_file_name in pairs(require("utils").servers) do
    local lsp_opts = {
      capabilities = capabilities,
    }

    local server_name = vim.split(server_file_name, "@")[1]

    local require_ok, conf_opts = pcall(require, "plugins.lsp-overrides." .. server_name)
    if require_ok then
      lsp_opts = vim.tbl_deep_extend("force", conf_opts, lsp_opts)
    end

    if conf_opts.extra_on_attach ~= nil then
      lsp_opts.on_attach = function(client, buffer_number)
        custom_on_attach(client, buffer_number)
        conf_opts.extra_on_attach(client, buffer_number)
      end
    else
      lsp_opts.on_attach = custom_on_attach
    end

    local lspconfig = require "lspconfig"
    lspconfig[server_name].setup(lsp_opts)
  end

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    signs = {
      active = signs,
    },
    update_in_insert = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
    },
    virtual_text = true,
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {})

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {})
end

return M
