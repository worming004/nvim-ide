local lsp_clients = function()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  local names = {}
  for _, client in pairs(buf_clients) do
    table.insert(names, client.name)
  end
  return table.concat(names, ", ")
end

local mcp_clients = function()
  -- Check if MCPHub is loaded
  if not vim.g.loaded_mcphub then
    return "󰐻 -"
  end

  local count = vim.g.mcphub_servers_count or 0
  local status = vim.g.mcphub_status or "stopped"
  local executing = vim.g.mcphub_executing

  -- Show "-" when stopped
  if status == "stopped" then
    return "󰐻 -"
  end

  -- Show spinner when executing, starting, or restarting
  if executing or status == "starting" or status == "restarting" then
    local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local frame = math.floor(vim.loop.now() / 100) % #frames + 1
    return "󰐻 " .. frames[frame]
  end

  return "󰐻 " .. count
end

return {
  "nvim-lualine/lualine.nvim",
  event  = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  config = function()
    local lualine = require "lualine"

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = true,
      always_visible = true,
    }

    local filetype = {
      "filetype",
      icons_enabled = true,
    }

    local location = {
      "location",
      padding = 0,
    }

    local spaces = function()
      return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    lualine.setup {
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename", diagnostics, "windows" },
        lualine_x = { mcp_clients, lsp_clients, spaces, "encoding", filetype },
        lualine_y = { location },
        lualine_z = { "progress" },
      },
    }
  end
}
