local fn = vim.fn
if fn.bufname('%') == '' then
  if fn.empty(fn.getline(1, '$')) then
    vim.cmd ":NvimTreeFocus"
  end
end
