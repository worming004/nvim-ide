local M = {
  "neovim/nvim-lspconfig",
  branch = "master",
  version = "*",
  -- dir = "/home/worming/git/neovim/nvim-lspconfig",
  config = function()
    -- local cmp_nvim_lsp = require "cmp_nvim_lsp"
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- not sure what this is doing
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- capabilities = cmp_nvim_lsp.default_capabilities(capabilities)


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

      require("keymaps").lsp_buffer_setup(buffer_number)
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
      { name = "DiagnosticSignHint", text = "💡" },
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
  end,
  dependencies = {
    {
      "mason-org/mason.nvim",
      lazy = false,
      command = ":Mason",
      build = ":MasonUpdate",
      version = "*",
      config = function()
        require("mason").setup({
          ui = {
            border = "none",
            icons = {
              package_installed = "◍",
              package_pending = "◍",
              package_uninstalled = "◍",
            },
          },
          log_level = vim.log.levels.INFO,
          max_concurrent_installers = 6,
        })
      end
    },
    "Hoffs/omnisharp-extended-lsp.nvim",
    "barreiroleo/ltex_extra.nvim",
    {
      "worming004/lsp-lens.nvim",
      lazy = false,
      opts = {
        target_symbol_kinds = {
          vim.lsp.protocol.SymbolKind.Function,
          vim.lsp.protocol.SymbolKind.Method,
          vim.lsp.protocol.SymbolKind.Interface,
          vim.lsp.protocol.SymbolKind.Class,
          vim.lsp.protocol.SymbolKind.Struct,
        },
      }
    },
    { "folke/neodev.nvim", opts = {} },
  }
}

return M
