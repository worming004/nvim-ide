vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.cmd(":compiler go")
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
      -- dear reader try 'dotnet build ./my.sln' and 'dotnet build ./my.sln | cat' just to laugh
      vim.bo.makeprg = "dotnet build " .. solution_path .. "  2>&1 \\| awk '/Build FAILED/ {exit} {print}'"
    else
      vim.notify("No .sln file found in the current project!", vim.log.levels.WARN)
    end
    vim.bo.errorformat = "%f(%l\\,%c): %t%.%#: %m,%-G%.%#"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "elixir",
  callback = function()
    vim.bo.makeprg = "mix compile"
    vim.opt_local.errorformat = table.concat({
      "%E%.%#%trror:%m",
      -- last line of multiline contains file name, row and col
      "%Z%.%# %f:%l:%c: %m",
      -- exclude lines with ^ that is positional information
      "%C%.%#│%*[ ]^",
      -- extract error message, this is the actual faulty code
      "%C%.%#│%*[ ]%m",
      -- accept any line as continuation of multiline
      "%C%.%#",
      -- ignore everything else
      "%-G%.%#",
    }, ",")
  end
})
