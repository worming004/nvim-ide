-- Shorten function name
local keymap = vim.keymap.set

local utils = require("utils")

-- silent is used to remove flickering with noice
local opts = { silent = true }
local function optsWithDesc(p_opts, description)
  vim.tbl_deep_extend("force", p_opts, { description = description })
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<leader>rj", "<cmd>resize -20<CR>", optsWithDesc(opts, "Big horizontal resize negative"))
keymap("n", "<leader>rk", "<cmd>resize +20<CR>", optsWithDesc(opts, "Big horizontal resize positive"))
keymap("n", "<leader>rh", "<cmd>vertical resize -20<CR>", optsWithDesc(opts, "Big vertical resize negative"))
keymap("n", "<leader>rl", "<cmd>vertical resize +20<CR>", optsWithDesc(opts, "Big vertical resize positive"))
keymap("n", "<leader>rJ", "<cmd>resize -5<CR>", optsWithDesc(opts, "Small horizontal resize negative"))
keymap("n", "<leader>rK", "<cmd>resize +5<CR>", optsWithDesc(opts, "Small horizontal resize positive"))
keymap("n", "<leader>rH", "<cmd>vertical resize -5<CR>", optsWithDesc(opts, "Small vertical resize negative"))
keymap("n", "<leader>rL", "<cmd>vertical resize +5<CR>", optsWithDesc(opts, "Small vertical resize positive"))

-- LspSaga
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
keymap("n", "gr", "<cmd>Lspsaga finder<CR>")
keymap("n", "gy", "<cmd>Lspsaga finder imp<CR>")
keymap({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>")
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
-- keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")
keymap("n", "gT", "<cmd>Lspsaga peek_type_definition<CR>")
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
keymap("n", "<leader>si", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<leader>so", "<cmd>Lspsaga outgoing_calls<CR>")




-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", ":bdelete<CR>", optsWithDesc(opts, "Delete buffer"))

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter normal mode from insert mode
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>oe", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>oo", ":NvimTreeFocus<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
keymap("n", "<leader>fr", ":Telescope registers<CR>", opts)
keymap("n", "<leader>fc", ":Telescope command_history<CR>", opts)
keymap("n", "<leader>fC", ":Telescope commands<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fM", ":Telescope man_pages<CR>", opts)
keymap("n", "<leader>fo", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fgs", ":Telescope git_status<CR>", opts)
keymap("n", "<leader>fgc", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>fs", ":Telescope luasnip<CR>", opts)

-- Git
keymap("n", "<leader>gb", "<cmd>:Gitsigns toggle_current_line_blame<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>uf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("n", "<leader>llr", "<cmd>LspRestart<cr>", opts)


-- Lazy
keymap("n", "<leader>bs", ":w<cr>", opts)
-- create new line in normal mode
keymap("n", "<leader>eo", "o<Esc>", optsWithDesc(opts, "New line below"))
keymap("n", "<leader>eO", "O<Esc>", optsWithDesc(opts, "New line above"))

keymap("n", "<leader>ts", ":TestSuite<CR>", opts)

-- Navbuddy
keymap("n", "<leader>nb", ":Navbuddy<CR>", optsWithDesc(opts, "Open Navbuddy"))

-- notify
keymap(
  "n",
  "<C-n>",
  "<cmd>lua require'notify'.dismiss { silent = true, pending = true }<cr>",
  optsWithDesc(opts, "Dismiss notifications")
)
keymap(
  "i",
  "<C-n>",
  "<cmd>lua require'notify'.dismiss { silent = true, pending = true }<cr>",
  optsWithDesc(opts, "Dismiss notifications")
)

-- buffer line
keymap("n", "<leader>ubp", ":BufferLineTogglePin<cr>", opts)

-- move in insert mode
keymap("i", "<C-h>", "<Left>", optsWithDesc(opts, "Move left"))
keymap("i", "<C-j>", "<Down>", optsWithDesc(opts, "Move down"))
keymap("i", "<C-k>", "<Up>", optsWithDesc(opts, "Move up"))
keymap("i", "<C-l>", "<Right>", optsWithDesc(opts, "Move right"))

keymap("n", "<leader>e;", function()
  utils.execute_then_come_back_at_original_position(function()
    vim.cmd ":normal A;"
  end)
end, optsWithDesc(opts, "Insert semi colon (;) at end of line"))
keymap("n", "<leader>e,", function()
  utils.execute_then_come_back_at_original_position(function()
    vim.cmd ":normal A,"
  end)
end, optsWithDesc(opts, "Insert colon (,) at end of line"))
