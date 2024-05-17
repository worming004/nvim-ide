-- helpers
local default_config = { noremap = true, silent = true }
local utils = require "utils"

local function all_buffers_setup()
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

  -- Windown navigation
  normal_default("<C-h>", "<C-w>h")
  normal_default("<C-j>", "<C-w>j")
  normal_default("<C-k>", "<C-w>k")
  normal_default("<C-l>", "<C-w>l")

  -- Lsp
  normal_default("<leader>uf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>")
  normal_default("<leader>llr", "<cmd>LspRestart<cr>")

  -- nvim-tree
  -- fix only on attach
  -- local api = require "nvim-tree.api"
  -- normal_default("<CR>", api.node.open.edit)
  -- normal_default("<C-v>", api.node.open.vertical)
  -- normal_default("<C-h>", api.node.open.horizontal)
  normal_default("<leader>oe", ":NvimTreeToggle<CR>")
  normal_default("<leader>oo", ":NvimTreeFocus<CR>")

  -- harpoon
  local mark = require("harpoon.mark")
  local ui = require("harpoon.ui")

  normal_default("<leader>a", function()
    mark.add_file()
    local file_index = mark.get_current_index()
    vim.notify("file added at index " .. file_index)
  end, { desc = "add file to harpoon" })
  normal_default("<leader>nho", ui.toggle_quick_menu, { desc = "open harpoon" })
  normal_default("<leader>nhr", mark.rm_file, { desc = "rm current file from harpoon" })
  normal_default("<leader>nhc", mark.clear_all, { desc = "clear all harpoon" })
  normal_default("<leader>nhq", function()
    local contents = {}
    for idx = 1, mark.get_length() do
      local file = mark.get_marked_file_name(idx)
      if utils.is_null_or_empty(file) then
        file = "(empty)"
      end
      contents[idx] = string.format("%s: %s", idx, file)
    end
    local content = ""
    if table.getn(contents) == 0 then
      content = "no buffer marked"
    else
      content = table.concat(contents, "\n")
    end
    vim.notify(content)
  end, { desc = "harpoon quick print all marks in notification" })

  normal_default("<leader>nz", function() ui.nav_file(1) end, { desc = "open harpoon file 1-z" })
  normal_default("<leader>nx", function() ui.nav_file(2) end, { desc = "open harpoon file 2-x" })
  normal_default("<leader>nc", function() ui.nav_file(3) end, { desc = "open harpoon file 3-c" })
  normal_default("<leader>nv", function() ui.nav_file(4) end, { desc = "open harpoon file 4-v" })

  -- Duck
  normal_default("<leader>udd", function() require("duck").hatch() end, { desc = "release a duck" })
  normal_default("<leader>uds", function() require("duck").hatch('ඞ', 5) end, { desc = "release sus" })
  normal_default("<leader>udp", function() require("duck").hatch('💩', 50) end, { desc = "release poop" })
  normal_default("<leader>udc", function()
    local d = require("duck")
    local s = require("utils.duck_strategy")
    d.hatch("🦆", 5, "none", s:top_right_corner_strategy())
    d.hatch("🐈", 4, "none", s:top_right_corner_strategy())
  end, { desc = "release poop" })

  -- Navbuddy
  normal_default("<leader>nb", ":Navbuddy<CR>", { desc = "Open Navbuddy" })

  -- Aerial
  normal_default("<leader>nao", function()
    local aerial = require("aerial")
    aerial.open()
    aerial.focus()
  end, { desc = "Open and focus on aerial" })
  normal_default("<leader>nat", ":AerialToggle<CR>", { desc = "Toggle Aerial" })

  -- Notify
  normal_default(
    "<C-n>",
    "<cmd>lua require'notify'.dismiss { silent = true, pending = true }<cr>",
    { desc = "Dismiss notifications" }
  )
  insert_default(
    "<C-n>",
    "<cmd>lua require'notify'.dismiss { silent = true, pending = true }<cr>",
    { desc = "Dismiss notifications" }
  )

  -- Move in insert mode
  insert_default("<C-h>", "<Left>", { desc = "Move cursor left" })
  insert_default("<C-j>", "<Down>", { desc = "Move cursor down" })
  insert_default("<C-k>", "<Up>", { desc = "Move cursor up" })
  insert_default("<C-l>", "<Right>", { desc = "Move cursor right" })

  -- Write files
  normal_default("<leader>ww", ":w<CR>", { desc = "write current buffer files" })
  normal_default("<leader>wa", ":wa<CR>", { desc = "write all files" })

  -- Copilot
  normal_default("<leader>co", ":CopilotChatOpen<CR>", { desc = "open copilot chat" })
  normal_default("<leader>cc", ":CopilotChatClose<CR>", { desc = "close copilot chat" })
  default({ "n", "v" }, "<leader>ce", ":CopilotChatExplain<CR>", { desc = "close copilot chat" })
  default({ "n", "v" }, "<leader>cf", ":CopilotChatFix<CR>", { desc = "fix with copilot chat" })
  default({ "n", "v" }, "<leader>co", ":CopilotChatOptimize<CR>", { desc = "optimize with copilot chat" })

  -- Git
  normal_default("<leader>ggl", ":!git pull<CR>", { desc = "git pull" })
end


local function lsp_buffer_setup(buffer_number)
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
end


return {
  all_buffers_setup = all_buffers_setup,
  lsp_buffer_setup = lsp_buffer_setup
}
