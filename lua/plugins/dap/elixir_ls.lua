local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"

return {
  config = {
    {
      type = "mix_task",
      name = "phoenix server",
      task = "phx.server",
      request = "launch",
      projectDir = "${workspaceFolder}",
      exitAfterTaskReturns = false,
      debugAutoInterpretAllModules = false,
    }
  },
  dap_adapter = {
    type = "executable",
    command = elixir_ls_debugger,
  }
}
