-- helpers
local default_config = { noremap = true, silent = true }
local utils = require "utils"

-- Buffer helper
local function default_buffer(buffer_number, mode, sequences, command, opt_extend)
  opt_extend = opt_extend or {}
  local overrided_opts = vim.tbl_deep_extend("force", default_config, opt_extend)
  vim.keymap.set(mode, sequences, command, overrided_opts)
  vim.api.nvim_buf_set_keymap(buffer_number, mode, sequences, command, overrided_opts)
end

---keymap for normal mode in specific buffers
---@param buffer_number integer
---@param sequences string
---@param command string|function()nil
---@param opt_extend? table
local function normal_buffer(buffer_number, sequences, command, opt_extend)
  default_buffer(buffer_number, "n", sequences, command, opt_extend)
end

---keymap for insert mode in specific buffers
---@param buffer_number integer
---@param sequences string
---@param command string|function
---@param opt_extend? table
local function insert_buffer(buffer_number, sequences, command, opt_extend)
  default_buffer(buffer_number, "i", sequences, command, opt_extend)
end

-- All Buffer helpers
local function default(mode, sequences, command, opt_extend)
  opt_extend = opt_extend or {}
  local overrided_opts = vim.tbl_deep_extend("force", default_config, opt_extend)
  vim.keymap.set(mode, sequences, command, overrided_opts)
end

---keymap for normal mode in all buffers
---@param sequences string
---@param command string|function
---@param opt_extend? table
local function normal(sequences, command, opt_extend)
  default("n", sequences, command, opt_extend)
end

---keymap for insert mode in all buffers
---@param sequences string
---@param command string|function
---@param opt_extend? table
local function insert(sequences, command, opt_extend)
  default("i", sequences, command, opt_extend)
end

---keymap for visual mode in all buffers
---@param sequences string
---@param command string|function
---@param opt_extend? table
local function visual(sequences, command, opt_extend)
  default("v", sequences, command, opt_extend)
end

local function all_buffers_setup()
  insert("jk", "<ESC>")

  -- Telescope
  normal("<leader>ff", ":Telescope find_files<CR>")
  normal("<leader>ft", ":Telescope live_grep<CR>")
  normal("<leader>fb", ":Telescope buffers<CR>")
  normal("<leader>fk", ":Telescope keymaps<CR>")
  normal("<leader>fr", ":Telescope registers<CR>")
  normal("<leader>fc", ":Telescope command_history<CR>")
  normal("<leader>fC", ":Telescope commands<CR>")
  normal("<leader>fd", ":Telescope diagnostics<CR>")
  normal("<leader>fM", ":Telescope man_pages<CR>")
  normal("<leader>fo", ":Telescope oldfiles<CR>")
  normal("<leader>fgs", ":Telescope git_status<CR>")
  normal("<leader>fgc", ":Telescope git_commits<CR>")
  normal("<leader>fs", ":Telescope luasnip<CR>")

  -- Windown navigation
  normal("<C-h>", "<C-w>h")
  normal("<C-j>", "<C-w>j")
  normal("<C-k>", "<C-w>k")
  normal("<C-l>", "<C-w>l")

  -- Lsp
  normal("<leader>uf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>")
  normal("<leader>llr", "<cmd>LspRestart<cr>")

  -- Nvim-tree
  normal("<leader>oe", ":NvimTreeToggle<CR>")
  normal("<leader>oo", ":NvimTreeFocus<CR>")

  -- harpoon
  local mark = require("harpoon.mark")
  local ui = require("harpoon.ui")

  normal("<leader>a", function()
    mark.add_file()
    local file_index = mark.get_current_index()
    vim.notify("file added at index " .. file_index)
  end, { desc = "add file to harpoon" })
  normal("<leader>nho", ui.toggle_quick_menu, { desc = "open harpoon" })
  normal("<leader>nhr", mark.rm_file, { desc = "rm current file from harpoon" })
  normal("<leader>nhc", mark.clear_all, { desc = "clear all harpoon" })
  normal("<leader>nhq", function()
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

  normal("<leader>nz", function() ui.nav_file(1) end, { desc = "open harpoon file 1-z" })
  normal("<leader>nx", function() ui.nav_file(2) end, { desc = "open harpoon file 2-x" })
  normal("<leader>nc", function() ui.nav_file(3) end, { desc = "open harpoon file 3-c" })
  normal("<leader>nv", function() ui.nav_file(4) end, { desc = "open harpoon file 4-v" })

  -- Duck
  normal("<leader>udd", function() require("duck").hatch() end, { desc = "release a duck" })
  normal("<leader>uds", function() require("duck").hatch('ඞ', 5) end, { desc = "release sus" })
  normal("<leader>udp", function() require("duck").hatch('💩', 50) end, { desc = "release poop" })
  normal("<leader>udc", function()
    local d = require("duck")
    local s = require("utils.duck_strategy")
    d.hatch("🦆", 5, "none", s:top_right_corner_strategy())
    d.hatch("🐈", 4, "none", s:top_right_corner_strategy())
  end, { desc = "release poop" })

  -- Navbuddy
  normal("<leader>nb", ":Navbuddy<CR>", { desc = "Open Navbuddy" })

  -- Aerial
  normal("<leader>nao", function()
    local aerial = require("aerial")
    aerial.open()
    aerial.focus()
  end, { desc = "Open and focus on aerial" })
  normal("<leader>nat", ":AerialToggle<CR>", { desc = "Toggle Aerial" })

  -- Notify
  normal(
    "<C-n>",
    "<cmd>lua require'notify'.dismiss { silent = true, pending = true }<cr>",
    { desc = "Dismiss notifications" }
  )
  insert(
    "<C-n>",
    "<cmd>lua require'notify'.dismiss { silent = true, pending = true }<cr>",
    { desc = "Dismiss notifications" }
  )

  -- Move in insert mode
  insert("<C-h>", "<Left>", { desc = "Move cursor left" })
  insert("<C-j>", "<Down>", { desc = "Move cursor down" })
  insert("<C-k>", "<Up>", { desc = "Move cursor up" })
  insert("<C-l>", "<Right>", { desc = "Move cursor right" })

  -- Write files
  normal("<leader>ww", ":w<CR>", { desc = "write current buffer files" })
  normal("<leader>wa", ":wa<CR>", { desc = "write all files" })

  -- Copilot
  normal("<leader>co", ":CopilotChatOpen<CR>", { desc = "open copilot chat" })
  normal("<leader>cc", ":CopilotChatClose<CR>", { desc = "close copilot chat" })
  default({ "n", "v" }, "<leader>ce", ":CopilotChatExplain<CR>", { desc = "close copilot chat" })
  default({ "n", "v" }, "<leader>cf", ":CopilotChatFix<CR>", { desc = "fix with copilot chat" })
  default({ "n", "v" }, "<leader>co", ":CopilotChatOptimize<CR>", { desc = "optimize with copilot chat" })

  -- Git
  normal("<leader>ggl", ":!git pull<CR>", { desc = "git pull" })

  -- Buffers
  normal("<S-l>", function()
    vim.cmd('bnext')
  end)
  normal("<S-h>", function()
    vim.cmd('bprevious')
  end)

  -- End of line stuffes
  normal("<leader>e;", function()
    utils.execute_then_come_back_at_original_position(function()
      vim.cmd ":normal A;"
    end)
  end, { desc = "Insert semi colon (;) at end of line" })
  insert("<C-e>;", function()
    utils.execute_then_come_back_at_original_position(function()
      vim.cmd ":normal A;"
    end)
  end, { desc = "Insert semi colon (;) at end of line" })
  normal("<leader>e,", function()
    utils.execute_then_come_back_at_original_position(function()
      vim.cmd ":normal A,"
    end)
  end, { desc = "Insert colon (,) at end of line" })
  insert("<C-e>,", function()
    utils.execute_then_come_back_at_original_position(function()
      vim.cmd ":normal A,"
    end)
  end, { desc = "Insert semi colon (,) at end of line" })

  -- Windows
  normal("<leader>qa", ":qa!<CR>", { desc = "quit all windows" })
  normal("<leader>qw", ":q<CR>", { desc = "quit current window" })

  -- Kubectl
  normal("<leader>ka", ":KubeApply<CR>", { desc = "kubectl apply" })
  normal("<leader>kd", ":KubeDelete<CR>", { desc = "kubectl delete" })

  -- Resize
  normal("<leader>rj", "<cmd>resize -20<CR>", { desc = "Big horizontal resize negative" })
  normal("<leader>rk", "<cmd>resize +20<CR>", { desc = "Big horizontal resize positive" })
  normal("<leader>rh", "<cmd>vertical resize -20<CR>", { desc = "Big vertical resize negative" })
  normal("<leader>rl", "<cmd>vertical resize +20<CR>", { desc = "Big vertical resize positive" })
  normal("<leader>rJ", "<cmd>resize -5<CR>", { desc = "Small horizontal resize negative" })
  normal("<leader>rK", "<cmd>resize +5<CR>", { desc = "Small horizontal resize positive" })
  normal("<leader>rH", "<cmd>vertical resize -5<CR>", { desc = "Small vertical resize negative" })
  normal("<leader>rL", "<cmd>vertical resize +5<CR>", { desc = "Small vertical resize positive" })

  -- Stay in indent mode
  visual("<", "<gv")
  visual(">", ">gv")
end


local function lsp_buffer_setup(buffer_number)
  normal_buffer(buffer_number, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  normal_buffer(buffer_number, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  normal_buffer(buffer_number, "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  normal_buffer(buffer_number, "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
  normal_buffer(buffer_number, "<leader>lgr", "<cmd>lua vim.lsp.buf.references()<CR>")
  normal_buffer(buffer_number, "<leader>lla", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  normal_buffer(buffer_number, "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>")
  normal_buffer(buffer_number, "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>")
  normal_buffer(buffer_number, "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>")
  normal_buffer(buffer_number, "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  normal_buffer(buffer_number, "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
  normal_buffer(buffer_number, "<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
  normal_buffer(buffer_number, "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  normal_buffer(buffer_number, "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

  insert_buffer(buffer_number, "<C-U>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
end


return {
  all_buffers_setup = all_buffers_setup,
  lsp_buffer_setup = lsp_buffer_setup,
}
