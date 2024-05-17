-- helpers
local default_config = { noremap = true, silent = true }

local function default(mode, sequences, command, opt_extend)
  opt_extend = opt_extend or {}
  local overrided_opts = vim.tbl_deep_extend("force", default_config, opt_extend)
  vim.keymap.set(mode, sequences, command, overrided_opts)
end

local function normal_default(sequences, command, opt_extend)
  default("n", sequences, command, opt_extend)
end

local function insert_default(sequences, command, opt_extend)
  default("i", sequences, command, opt_extend)
end

insert_default("jk", "<ESC>")

-- Telescope
normal_default("<leader>ff", ":Telescope find_files<CR>")
normal_default("<leader>ft", ":Telescope live_grep<CR>")
normal_default("<leader>fb", ":Telescope buffers<CR>")
normal_default("<leader>fk", ":Telescope keymaps<CR>")
normal_default("<leader>fr", ":Telescope registers<CR>")
normal_default("<leader>fc", ":Telescope command_history<CR>")
normal_default("<leader>fC", ":Telescope commands<CR>")
normal_default("<leader>fd", ":Telescope diagnostics<CR>")
normal_default("<leader>fM", ":Telescope man_pages<CR>")
normal_default("<leader>fo", ":Telescope oldfiles<CR>")
normal_default("<leader>fgs", ":Telescope git_status<CR>")
normal_default("<leader>fgc", ":Telescope git_commits<CR>")
normal_default("<leader>fs", ":Telescope luasnip<CR>")

--lsp
normal_default("<leader>uf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>")
normal_default("<leader>llr", "<cmd>LspRestart<cr>")

-- nvim-tree
local api = require "nvim-tree.api"
normal_default("<CR>", api.node.open.edit)
normal_default("<C-v>", api.node.open.vertical)
normal_default("<C-h>", api.node.open.horizontal)
normal_default("<leader>oe", ":NvimTreeToggle<CR>")
normal_default("<leader>oo", ":NvimTreeFocus<CR>")

return {
  for_lsp = function(buffer_number)
    local normal_default_buffer = function(sequences, command, opt_extend)
      opt_extend = opt_extend or {}
      local overrided_opts = vim.tbl_deep_extend("force", default_config, opt_extend)
      vim.api.nvim_buf_set_keymap(buffer_number, "n", sequences, command, overrided_opts)
    end
    normal_default_buffer("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    normal_default_buffer("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    normal_default_buffer("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    normal_default_buffer("gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
    normal_default_buffer("<leader>lgr", "<cmd>lua vim.lsp.buf.references()<CR>")
    normal_default_buffer("<leader>lla", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    normal_default_buffer("<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>")
    normal_default_buffer("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>")
    normal_default_buffer("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>")
    normal_default_buffer("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    normal_default_buffer("<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    normal_default_buffer("<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
    normal_default_buffer("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>")
    normal_default_buffer("<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    normal_default_buffer("<C-U>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  end,
}
