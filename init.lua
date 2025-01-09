require "helpers"
require "options"
require "plugin-loader"
require("keymaps").all_buffers_setup()
require "commands"
require "autocommands"
require "open-web"
require "generate-go-tests"
require "which-key-group"
require "make"

-- open nvimtree at startup
-- if NVIMTREE env variable is not set to 0
if os.getenv("NVIMTREE") ~= "0" then
  local fn = vim.fn
  if fn.bufname('%') == '' then
    if fn.empty(fn.getline(1, '$')) then
      vim.cmd ":NvimTreeFocus"
    end
  end
end

require "dotnet-build-src"
