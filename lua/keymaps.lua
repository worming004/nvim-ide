-- Shorten function name
local keymap = vim.keymap.set

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
keymap("n", "<C-w>t", ":terminal<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete<CR>", optsWithDesc(opts, "Delete buffer"))

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
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
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
keymap("n", "<leader>fr", ":Telescope registers<CR>", opts)
keymap("n", "<leader>fc", ":Telescope command_history<CR>", opts)
keymap("n", "<leader>fC", ":Telescope commands<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fM", ":Telescope man_pages<CR>", opts)
keymap("n", "<leader>fo", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fgs", ":Telescope git_status<CR>", opts)
keymap("n", "<leader>fgs", ":Telescope git_commit<CR>", opts)

-- Git
keymap("n", "<leader>gb", "<cmd>:GitBlameToggle<CR>", opts)

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

-- Lazy
keymap("n", "<C-s>", ":w<cr>", opts)
-- save in insert ode
keymap("i", "<C-s>", "<C-o>:w<cr>", opts)
-- create new line in normal mode
keymap("n", "<leader>eo", "o<Esc>", optsWithDesc(opts, "New line below"))
keymap("n", "<leader>eO", "O<Esc>", optsWithDesc(opts, "New line above"))

keymap("n", "<leader>ts", ":TestSuite<CR>", opts)


-- Navbuddy
keymap("n", "<leader>ub", ":Navbuddy<CR>", optsWithDesc(opts, "Open Navbuddy"))

-- notify
keymap(
  "n",
  "<leader>unc",
  "<cmd>lua require'notify'.dismiss { silent = true, pending = true }<cr>",
  optsWithDesc(opts, "Dismiss notifications")
)

-- buffer line
keymap(
  "n",
  "<leader>ubp",
  ":BufferLineTogglePin<cr>",
  opts
)

-- move in insert mode
keymap("i", "<C-h>", "<Left>", optsWithDesc(opts, "Move left"))
keymap("i", "<C-j>", "<Down>", optsWithDesc(opts, "Move down"))
keymap("i", "<C-k>", "<Up>", optsWithDesc(opts, "Move up"))
keymap("i", "<C-l>", "<Right>", optsWithDesc(opts, "Move right"))
