require "helpers"
require "options"
require "plugin-loader"
require("keymaps").all_buffers_setup()
require "commands"
require "autocommands"
require "open-web"
require "generate-go-tests"
require "which-key-group"

-- open nvimtree at startup
local fn = vim.fn
if fn.bufname('%') == '' then
  if fn.empty(fn.getline(1, '$')) then
    vim.cmd ":NvimTreeFocus"
  end
end

require "dotnet-build-src"
