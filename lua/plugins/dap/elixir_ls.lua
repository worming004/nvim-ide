local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"

return {
  configurations = {
    {
      type = "mix_task",
      name = "phoenix server",
      task = "phx.server",
      request = "launch",
      projectDir = "${workspaceFolder}",
      exitAfterTaskReturns = false,
      debugAutoInterpretAllModules = false,
    },
  },
  adapters = {
    mix_task = {
      type = 'executable',
      command = elixir_ls_debugger,
      args = {}
    }
  }
}
