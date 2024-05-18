return {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  config = function()
    require("dapui").setup {
      expand_lines = true,
      icons = { expanded = "", collapsed = "", circular = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl",    size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,             -- Floats will be treated as percentage of your screen.
        border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    }

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
  end,
  dependencies = {
    { "nvim-neotest/nvim-nio", event = "VeryLazy" },
    {
      "mfussenegger/nvim-dap",
      event = "VeryLazy",
      config = function()
        local dap = require "dap"
        local dapui = require "dapui"

        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close


        ---Configure daps
        ---@param name string|string[]
        ---@param c any
        local function merge_into_dap(name, c)
          if type(name) == "table" then
            for _, single_name in ipairs(name) do
              dap.configurations[single_name] = c.configurations
            end
          else
            dap.configurations[name] = c.configurations
          end
          table.merge_dictionary(dap.adapters, c.adapters)
        end

        local dotnet_config = require "plugins.dap.dotnet"
        merge_into_dap({ "cs", "fsharp" }, dotnet_config)

        local elixir_config = require "plugins.dap.elixir_ls"
        merge_into_dap("elixir", elixir_config)

        local go_config = require "plugins.dap.go"
        merge_into_dap("go", go_config)

        local lua_config = require "plugins.dap.lua"
        merge_into_dap("lua", lua_config)

        dap.adapters.coreclr = {
          type = "executable",
          command = "netcoredbg",
          args = { "--interpreter=vscode" },
        }
      end
    },
  },
}
