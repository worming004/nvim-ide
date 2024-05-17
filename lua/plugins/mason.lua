return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	cmd = "Mason",
	event = "BufReadPre",
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
			dependencies = { "neovim/nvim-lspconfig" },
			lazy = false
		}
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "none",
				icons = {
					package_installed = "◍",
					package_pending = "◍",
					package_uninstalled = "◍",
				},
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
		})
		require("mason-lspconfig").setup {
			ensure_installed = require("utils").servers,
			automatic_installation = true,
		}
	end,
}
