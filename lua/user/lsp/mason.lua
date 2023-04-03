local servers = {
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "elixirls",
  "gopls",
  "omnisharp",
  "angularls",
  "ansiblels",
  "rust_analyzer",
  "terraformls",
  "tflint",
  "lua_ls",
  "bicep",
  "powershell_es"
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end

local mason_nvim_dap = require("mason-nvim-dap")
mason_nvim_dap.setup({
  automatic_setup = true,
  ensure_installed = { "python", "delve" }
})
mason_nvim_dap.setup_handlers{}
require("dap-go").setup()

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
  print("dapui nok")
  return
end
dapui.setup{}

