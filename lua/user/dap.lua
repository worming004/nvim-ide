local M = {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    {
      "mfussenegger/nvim-dap",
      event = "VeryLazy",
      config = function()
        local dap = require "dap"
        local dapui = require "dapui"

        dapui.setup {
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

        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end

        -- TODO reinsert this ?
        -- -- go
        require("dap-go").setup()
        --
        -- -- dap
        -- require("mason-nvim-dap").setup()

        -- dotnet
        vim.g.dotnet_build_project = function()
          local default_path = vim.fn.getcwd() .. "/"
          if vim.g["dotnet_last_proj_path"] ~= nil then
            default_path = vim.g["dotnet_last_proj_path"]
          end
          local path = vim.fn.input("Path to your *proj file", default_path, "file")
          vim.g["dotnet_last_proj_path"] = path
          local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
          print ""
          print("Cmd to execute: " .. cmd)
          local f = os.execute(cmd)
          if f then
            print "\nBuild: ✔️ "
          else
            print "\nBuild: ❌"
            print(f)
          end
        end

        vim.g.dotnet_get_dll_path = function()
          local request = function()
            return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end

          if vim.g["dotnet_last_dll_path"] == nil then
            vim.g["dotnet_last_dll_path"] = request()
          else
            if
                vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2) == 1
            then
              vim.g["dotnet_last_dll_path"] = request()
            end
          end

          return vim.g["dotnet_last_dll_path"]
        end

        local config = {
          {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
              if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
                vim.g.dotnet_build_project()
              end
              return vim.g.dotnet_get_dll_path()
            end,
          },
        }

        dap.configurations.cs = config
        dap.configurations.fsharp = config

        dap.adapters.coreclr = {
          type = "executable",
          command = "netcoredbg",
          args = { "--interpreter=vscode" },
        }
      end
    },
    { "nvim-neotest/nvim-nio", event = "VeryLazy" }
  },
}

function M.config()
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
end

return M
