-- helpers
local k = vim.keymap.set
local o = {noremap = true, silent = true}

function default (mode, sequences, command, opt_extend)
	opt_extend = opt_extend or {}
	local overrided_opt = vim.tbl_deep_extend("force", o, opt_extend)
	vim.keymap.set(mode, sequences, command, overrided_opt)
end
function normal_default (sequences, command, opt_extend)
	default("n", sequences, command, opt_extent)
end

function insert_default (sequences, command, opt_extend)
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
