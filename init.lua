require "options"
require "mylazy"
require "keymaps"
require "commands"
require "autocommands"
require "open-web"
require "grenerate-go-tests"
require "which-key-group"


-- open nvimtree at startup
local fn = vim.fn
if fn.bufname('%') == '' then
  if fn.empty(fn.getline(1, '$')) then
    vim.cmd ":NvimTreeFocus"
  end
end
