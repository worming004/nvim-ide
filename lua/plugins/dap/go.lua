local dlv = vim.fn.exepath "dlv"
-- in rea
return {
  adapters = {
    go = {
      type = "server",
      port = "${port}",
      executable = {
        command = dlv,
        args = { 'dap', '-l', '127.0.0.1:${port}' },
      }
    }
  },
  configurations = {
    {
      type = "go", -- should match dap.adapters.<adapter-name>
      name = "Debug",
      request = "launch",
      showLog = true,
      program = "${file}",
    },
  },
}
