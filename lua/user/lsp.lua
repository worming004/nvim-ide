-- Looking for settings ? https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
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
  },
}

function M.config()
  local cmp_nvim_lsp = require "cmp_nvim_lsp"
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- not sure what this is doing
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>lgr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- Keep this code_action keymap waiting few fixes in folke/which-key.nvim
    keymap(bufnr, "n", "<leader>lla", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
    keymap(bufnr, "n", "<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", opts)
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    keymap(bufnr, "n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
    keymap(bufnr, "i", "<C-U>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  end

  local lspconfig = require "lspconfig"

  -- https://www.reddit.com/r/neovim/comments/y9qv1w/autoformatting_on_save_with_vimlspbufformat_and/
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local custom_on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if vim.g.autoformat then
            vim.lsp.buf.format()
          end
        end,
      })
    end

    -- autoformat on save
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if vim.g.autoformat then
            vim.lsp.buf.format()
          else
            vim.notify("Autoformat deactivated")
          end
        end,
      })
    end

    lsp_keymaps(bufnr)
  end

  for _, server in pairs(require("utils").servers) do
    local lsp_opts = {
      capabilities = capabilities,
    }


    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "settings." .. server)
    if require_ok then
      lsp_opts = vim.tbl_deep_extend("force", conf_opts, lsp_opts)
    end

    -- if personal server configuration define an extra_on_attach, attach to it
    if conf_opts.extra_on_attach ~= nil then
      lsp_opts.on_attach = function(client, bufnr)
        custom_on_attach(client, bufnr)
        conf_opts.extra_on_attach(client, bufnr)
      end
    else
      lsp_opts.on_attach = custom_on_attach
    end

    lspconfig[server].setup(lsp_opts)
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
    virtual_text = true,
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
