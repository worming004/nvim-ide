local M = {}

local win_hl_namespace = vim.api.nvim_create_namespace('win_hl_namespace')

local function get_buffer()
  local buffers = {}
  for _, bufnr in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    local t = {
      id = bufnr.bufnr,
      name = bufnr.name,
    }
    table.insert(buffers, t)
  end
  return buffers
end

local function map_name(buffers)
  local t = {}
  for _, v in ipairs(buffers) do
    table.insert(t, v.name)
  end
  return t
end

local function find_index_by_id(buffers, id)
  for i, v in ipairs(buffers) do
    if v.id == id then
      return i
    end
  end

  return -1
end

local function find_max_length(buffers)
  local max = 0

  for _, v in ipairs(buffers) do
    if #(v.name) > max then
      max = #(v.name)
    end
  end

  return max
end

local latest_win = nil
local function clear_latest()
  vim.api.nvim_win_close(latest_win, { force = true })
end

local function experience()
  local active_buffer_id = vim.fn.bufnr('%')
  local buf_to_present_id = vim.api.nvim_create_buf(false, true)
  local all_buffers = get_buffer()
  local length = find_max_length(all_buffers)
  vim.api.nvim_buf_set_lines(buf_to_present_id, 0, -1, true, map_name(all_buffers))

  -- highlight current buffer
  local active_line = find_index_by_id(all_buffers, active_buffer_id)
  local highlight_group = 'ErrorMsg' -- You can use a different highlight group if you prefer
  if active_line >= 0 then
    local start_col = 0
    vim.api.nvim_buf_add_highlight(buf_to_present_id, win_hl_namespace, highlight_group, active_line - 1, start_col,
      length)
  end

  -- print buffer in window
  local opts = {
    relative = "win",
    anchor   = "SW",
    col      = vim.o.columns,
    row      = 0,
    width    = length,
    height   = #all_buffers,
    style    = "minimal",
    border   = "single",
  }
  latest_win = vim.api.nvim_open_win(buf_to_present_id, false, opts)
end


-- reload section
vim.keymap.set('n', '<space><space>r', function()
  vim.cmd('luafile ~/.config/nvim/lua/buffer-window.lua')
end)

vim.keymap.set('n', '<space><space>e', function()
  experience()
end)

vim.keymap.set('n', '<space><space>d', function()
  clear_latest()
end)

return M
