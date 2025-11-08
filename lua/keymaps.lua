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
  -- Modes
  insert("jk", "<ESC>", { desc = "Escape in insert mode" })

  -- Telescope
  normal("<leader>ff", ":Telescope find_files<CR>")
  normal("<leader>ft", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
  normal("<leader>fl", ":Telescope live_grep<CR>")
  normal("<leader>fb", ":Telescope buffers<CR>")
  normal("<leader>fe", ":Telescope emoji<CR>")
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

  -- Window navigation
  normal("<C-h>", "<C-w>h")
  normal("<C-j>", "<C-w>j")
  normal("<C-k>", "<C-w>k")
  normal("<C-l>", "<C-w>l")

  -- Lsp
  normal("<leader>uf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>")
  normal("<leader>llr", "<cmd>LspRestart<cr>")
  normal("<leader>llst", "<cmd>LspStop<cr>")

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
  normal("<leader>nb", function() ui.nav_file(5) end, { desc = "open harpoon file 5-b" })

  -- Duck
  normal("<leader>udd", function() require("duck").hatch() end, { desc = "release a duck" })
  normal("<leader>uds", function() require("duck").hatch('ඞ', 5) end, { desc = "release sus" })
  normal("<leader>udp", function() require("duck").hatch('💩', 50) end, { desc = "release poop" })

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
  default({ "n", "v" }, "<leader>cc", ":CopilotChatClose<CR>", { desc = "close copilot chat" })
  default({ "n", "v" }, "<leader>ct", ":CopilotChatToggle<CR>", { desc = "Toggle copilot chat" })
  default({ "n", "v" }, "<leader>ce", ":CopilotChatExplain<CR>", { desc = "explain copilot chat" })
  default({ "n", "v" }, "<leader>cf", ":CopilotChatFix<CR>", { desc = "fix with copilot chat" })
  default({ "n", "v" }, "<leader>cO", ":CopilotChatOptimize<CR>", { desc = "optimize with copilot chat" })

  -- Git
  normal("<leader>ggp", ":!git pull<CR>", { desc = "git pull" })
  normal("<leader>ggP", ":!git push<CR>", { desc = "git push" })
  normal("<leader>ggfa", ":!git fetch --all --tags --prune --jobs=10<CR>", { desc = "git fetch all prune and tags" })

  -- Buffers
  normal("<S-l>", function()
    vim.cmd('bnext')
  end)
  normal("<S-h>", function()
    vim.cmd('bprevious')
  end)


  -- Windows
  normal("<leader>qa", ":qa!<CR>", { desc = "quit all windows" })
  normal("<leader>qw", ":q<CR>", { desc = "quit current window" })
  normal("<C-x>", ":q<CR>", { desc = "quit current window" })

  -- Kubectl
  normal("<leader>ka", ":KubeApply<CR>", { desc = "kubectl apply" })
  normal("<leader>kd", ":KubeDelete<CR>", { desc = "kubectl delete" })
  normal("<leader>kt", ":KubeApplyDryRun<CR>", { desc = "kubectl apply with dry run server side" })

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

  -- Dap
  normal("<F6>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "(debug) Toggle breakpoing" })
  normal("<F1>", "<cmd>lua require'dap'.continue()<cr>", { desc = "(debug) Continue" })
  normal("<F2>", "<cmd>lua require'dap'.step_into()<cr>", { desc = "(debug) step into" })
  normal("<F3>", "<cmd>lua require'dap'.step_over()<cr>", { desc = "(debug) step over" })
  normal("<F4>", "<cmd>lua require'dap'.step_out()<cr>", { desc = "(debug) step out" })

  normal("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "(debug) Run last" })
  normal("<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "(debug) Ui toggle" })
  normal("<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", { desc = "(debug) Terminate dap" })

  -- Diagnostic
  normal("<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>")
  normal("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>")
  normal("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  normal("gl", "<cmd>lua vim.diagnostic.open_float()<CR>")


  -- test temporarly without to ensure not needed anymore
  -- LspSaga
  -- normal("K", "<cmd>Lspsaga hover_doc<CR>") -- reactivate in lsp.lua it wants to remove
  -- normal("gr", "<cmd>Lspsaga finder<CR>")
  -- normal("gy", "<cmd>Lspsaga finder imp<CR>")
  -- default({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>")
  -- normal("gp", "<cmd>Lspsaga peek_definition<CR>")
  -- normal("gd", "<cmd>Lspsaga goto_definition<CR>")
  -- normal("gt", "<cmd>Lspsaga goto_type_definition<CR>")
  -- normal("gT", "<cmd>Lspsaga peek_type_definition<CR>")
  -- normal("<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
  -- normal("<leader>si", "<cmd>Lspsaga incoming_calls<CR>")
  -- normal("<leader>so", "<cmd>Lspsaga outgoing_calls<CR>")

  -- Plenary
  normal("<leader>tlf", ":PlenaryBustedFile %<CR>", { desc = "Run lua tests from current buffer" })
  normal("<leader>tld", ":PlenaryBustedDirectory .<CR>", { desc = "Run all lua tests" })

  -- Neotest
  default({ "n", "v" }, "<C-t>", function() require("neotest").run.run(vim.fn.getcwd()) end, { desc = "Run all tests" })
  normal("<leader>tra", function() require("neotest").run.run(vim.fn.getcwd()) end, { desc = "Run all tests" })
  normal("<leader>trf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run file tests" })
  normal("<leader>trf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run file tests" })
  -- elixir special case
  normal("<leader>trea", function() require("neotest").run.run("test") end, { desc = "Run all tests" })

  normal("<leader>tds", function() require("neotest").run.run({ strategy = "dap", suite = false }) end,
    { desc = "Debug single test" })
  normal("<leader>tdl", function() require("neotest").run.run_last({ strategy = "dap", suite = false }) end,
    { desc = "Debug latest test" })

  normal("<leader>ts", ":Neotest summary<CR>", { desc = "Open test summary" })
  normal("<leader>to", ":Neotest output-panel<CR>", { desc = "Open Neotest output panel" })

  normal("<leader>ntn", function() require("neotest").jump.next({ status = "failed" }) end,
    { desc = "Go to next failling test" })
  normal("<leader>ntp", function() require("neotest").jump.previous({ status = "failed" }) end,
    { desc = "Go to previous failling test" })

  -- Registry
  normal("<leader>-", "\"_", { desc = "do not override registry", silent = false })

  -- Markdown
  normal("<leader>umw", ":MarkdownPreview<CR>", { desc = "Toggle markdown preview in web browser" })
  normal("<leader>umt", ":Markview toggle<CR>", { desc = "Toggle Markview plugin" })

  -- Blink
  insert("<C-n>", function()
    -- require("blink.cmp.completion.trigger").show()
    require("blink.cmp").show()
  end, { desc = "Trigger blink menu" })

  -- Pipeline
  normal("<leader>upt", "<cmd>Pipeline toggle<CR>", { desc = "Toggle pipeline plugin" })

  normal("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  normal("gd", vim.lsp.buf.definition)
  normal("dgd", require('omnisharp_extended').lsp_definition)
  normal("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  normal("K", "<cmd> lua vim.lsp.buf.hover()<CR>")
  normal("<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  normal("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  normal("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>")
  normal("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  normal("<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
  normal("<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
  normal("<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
  insert("<C-U>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
end

local function add_string_at_end_of_line(str)
  return function()
    utils.execute_then_come_back_at_original_position(function()
      vim.cmd(":normal A" .. str)
    end)
  end
end

-- for golang, new variable is made with := sign
local function replace_equal_by_colon_equal()
  local initial_line = vim.api.nvim_get_current_line()
  local new_line = initial_line:gsub("=", ":=", 1):gsub("::=", ":=", 1)
  vim.api.nvim_set_current_line(new_line)

  -- Move cursor to right if cursor is after the equal sign
  if new_line ~= initial_line then
    local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1
    local equal_pos = new_line:find(":=")

    if cursor_col > equal_pos then
      vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], cursor_col + 1 })
    end
  end
end

local function keymap_for_go(_buffer_number)
  vim.keymap.set("n", "<leader>=", replace_equal_by_colon_equal,
    { desc = "Make variable assignment onto new variable (= become :=)", buffer = true })
  vim.keymap.set("n", "<leader>e,", add_string_at_end_of_line(","),
    { desc = "Insert comma (,) at end of line", buffer = true })
  vim.keymap.set("i", "<C-e>,", add_string_at_end_of_line(","),
    { desc = "Insert comma (,) at end of line", buffer = true })
end

local function keymap_for_csharp(_buffer_number)
  vim.keymap.set("n", "<leader>e;", add_string_at_end_of_line(";"),
    { desc = "Insert semi colon (;) at end of line", buffer = true })
  vim.keymap.set("n", "<leader>e,", add_string_at_end_of_line(","),
    { desc = "Insert comma (,) at end of line", buffer = true })
  vim.keymap.set("i", "<C-e>;", add_string_at_end_of_line(";"),
    { desc = "Insert semi colon (;) at end of line", buffer = true })
  vim.keymap.set("i", "<C-e>,", add_string_at_end_of_line(","),
    { desc = "Insert comma (,) at end of line", buffer = true })
end

local function keymap_for_lua(_buffer_number)
  vim.keymap.set("n", "<leader>e,", add_string_at_end_of_line(","),
    { desc = "Insert comma (,) at end of line", buffer = true })
  vim.keymap.set("i", "<C-e>,", add_string_at_end_of_line(","),
    { desc = "Insert comma (,) at end of line", buffer = true })
end

local function keymap_for_python(_buffer_number)
  vim.keymap.set("n", "<leader>e,", add_string_at_end_of_line(","),
    { desc = "Insert comma (,) at end of line", buffer = true })
  vim.keymap.set("i", "<C-e>,", add_string_at_end_of_line(","),
    { desc = "Insert colon (,) at end of line", buffer = true })
  vim.keymap.set("n", "<leader>e:", add_string_at_end_of_line(":"),
    { desc = "Insert comma (:) at end of line", buffer = true })
  vim.keymap.set("i", "<C-e>:", add_string_at_end_of_line(":"),
    { desc = "Insert colon (:) at end of line", buffer = true })
end

return {
  all_buffers_setup = all_buffers_setup,
  keymap_for_go = keymap_for_go,
  keymap_for_csharp = keymap_for_csharp,
  keymap_for_lua = keymap_for_lua,
  keymap_for_python = keymap_for_python,
}
