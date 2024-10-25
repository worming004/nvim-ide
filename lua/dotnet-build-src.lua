local function run_dotnet_if_src_exists()
  local path = vim.fn.getcwd() -- Get the current working directory
  local src_path = path .. "/src/"
  local sln_file = vim.fn.glob(src_path .. "/*.sln")

  if vim.fn.isdirectory(src_path) == 1 and sln_file ~= "" then
    -- If the directory exists, run `dotnet run`
    vim.fn.jobstart({ "dotnet", "build" }, {
      cwd = src_path, -- Set working directory to src_path
      on_stdout = function(_, data)
        -- Handle standard output from the job
        if data then
          print(table.concat(data))
        end
      end,
      on_stderr = function(_, data)
        -- Handle errors
        if data then
          print("Error: " .. table.concat(data, "\n"))
        end
      end,
      on_exit = function(_, exit_code)
        -- Handle exit
        if exit_code == 0 then
          print("dotnet run completed successfully")
        else
          print("dotnet run failed with exit code: " .. exit_code)
        end
      end,
    })
  end
end

-- Call the function to run dotnet if src/ exists in the current directory
run_dotnet_if_src_exists()
