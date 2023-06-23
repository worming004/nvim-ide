local opts = {}
local opts_with_desc = function(o, desc)
  o.desc = desc
  return o
end

local utils = require "utils"

local function ensure_go_tests_cmd_exists()
  local exists = utils.check_command_exists("gotests", { warn = false })
  if exists ~= 1 then
    vim.fn.system "go install github.com/cweill/gotests/gotests@latest"
  end
  return exists
end

local function generate_test_file_name()
  local filename = vim.fn.expand "%:p"
  local extensionPosition = string.find(filename, "%.[^.]+$")
  if extensionPosition then
    return string.sub(filename, 1, extensionPosition - 1) .. "_test" .. string.sub(filename, extensionPosition)
  else
    return filename .. "_test"
  end
end

local function redirect_to_test_file()
  testfilename = generate_test_file_name()
  utils.redirect_user_to_file(testfilename)
end

vim.api.nvim_create_user_command("GenerateNamedGoTest", function(_)
  ensure_go_tests_cmd_exists()
  local filepath = vim.fn.expand "%:p"
  local current_word = vim.fn.expand "<cword>"

  vim.fn.system("gotests -w -only ^" .. current_word .. "$ " .. filepath)

  redirect_to_test_file()
end, opts_with_desc(opts, "Generate go test for function under cursor"))

vim.api.nvim_create_user_command("GenerateFileGoTest", function(_)
  ensure_go_tests_cmd_exists()
  local filepath = vim.fn.expand "%:p"

  vim.fn.system("gotests -w -all " .. filepath)

  redirect_to_test_file()
end, opts_with_desc(opts, "Generate go test for active buffer"))

vim.api.nvim_create_user_command("GeneratePackageGoTest", function(_)
  ensure_go_tests_cmd_exists()
  local filepath = vim.fn.expand "%:p"

  vim.fn.system("gotests -w -all " .. filepath)

  redirect_to_test_file()
end, opts_with_desc(opts, "Generate go test for whole package"))
