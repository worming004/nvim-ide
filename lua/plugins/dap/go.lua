local dlv = vim.fn.exepath "dlv"
-- in rea
return {
  adapter = {
    type = "server",
    port = "${port}",
    executable = {
      command = dlv,
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    }
  },
  config = {
    {
      type = "go", -- should match dap.adapters.<adapter-name>
      name = "Debug",
      request = "launch",
      showLog = true,
      program = "${file}",
    },
  },
}
