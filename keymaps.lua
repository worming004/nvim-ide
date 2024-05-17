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

