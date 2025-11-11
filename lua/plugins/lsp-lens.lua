return {
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
}
