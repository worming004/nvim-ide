require "helpers"
require "options"
require "plugin-loader"
require("keymaps").all_buffers_setup()
require "commands"
require "open_web"
require "generate_go_tests"
require "which-key-group"
require "make"
require "filetypes"

-- require "dotnet-build-src"

require "lsp"

require "autocommands"

local customs_dir = vim.fn.stdpath("config") .. "/lua/customs"
local stat = vim.loop.fs_stat(customs_dir)
if stat and stat.type == "directory" then
  for _, file in ipairs(vim.fn.readdir(customs_dir)) do
    if file:match("%.lua$") then
      local module = "customs." .. file:gsub("%.lua$", "")
      pcall(require, module)
    end
  end
end
