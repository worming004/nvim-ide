vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.bo.makeprg = "go build"
    vim.bo.errorformat = "%f:%l:%c: %m"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function()
    -- Find the .sln file, starting from the current directory
    local handle = io.popen("find . -name '*.sln' | head -n 1")
    local solution_path = handle:read("*a"):gsub("\n", "") -- Remove trailing newline
    handle:close()

    -- If a .sln file is found, set makeprg; otherwise, show a warning
    if solution_path ~= "" then
      vim.bo.makeprg = "dotnet build " .. solution_path
    else
      vim.notify("No .sln file found in the current project!", vim.log.levels.WARN)
    end
    vim.bo.errorformat = "%f(%l\\,%c):\\ %t%*[^:]:\\ %m"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "elixir",
  callback = function()
    vim.notify("setup make")
    vim.bo.makeprg = "mix compile"

    vim.opt_local.errorformat = table.concat({
      "%E%.%#%trror:%m",
      "%Z%.%# %f:%l:%c:%.%#",
      -- exclude lines with ^ that is positional information
      "%C%.%#│%*[ ]^",
      -- extract error message, this is the actual faulty code
      "%C%.%#│%*[ ]%m",
      -- accept any line as continuation of multiline
      "%C%.%#",
    }, ",")
  end
})
