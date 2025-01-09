vim.opt.clipboard = "unnamedplus" -- Use the system clipboard for all operations
vim.opt.shiftwidth = 2            -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 2               -- Number of spaces that a <Tab> in the file counts for
vim.opt.fileencoding = "utf-8"    -- File encoding to use
vim.opt.termguicolors = true      -- Enable 24-bit RGB color in the TUI
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.cursorline = true         -- Highlight the screen line of the cursor
vim.opt.relativenumber = true     -- Show line numbers relative to the current line
vim.opt.number = true             -- Show absolute line number on the cursor line (when relative number is on)
vim.opt.ruler = false             -- Don't show the line and column number of the cursor position
vim.opt.scrolloff = 8             -- Minimum number of screen lines to keep above and below the cursor
vim.opt.splitright = true         -- Vertical splits will automatically be to the right
vim.opt.splitbelow = true         -- Horizontal splits will automatically be below
vim.opt.iskeyword:append "-"      -- Treat dash separated words as a word text object
vim.opt.ignorecase = true         -- Ignore case in search patterns
vim.opt.smartcase = true          -- Override the 'ignorecase' option if the search pattern contains upper case characters
vim.opt.termguicolors = true      -- Enable 24-bit RGB color in the TUI (duplicate, can be removed)
vim.opt.signcolumn = "yes"        -- Always show the sign column
vim.opt.linebreak = true          -- Wrap long lines at a character in 'breakat'
vim.opt.inccommand = "split"      -- Show the effects of a command incrementally in a split window
vim.opt.swapfile = false          -- Don't use a swapfile for the buffer
vim.opt.list = true               -- Show some invisible characters (tabs, trailing spaces)

vim.g.mapleader = " "             -- Set the leader key to space
vim.g.autoformat = true           -- Enable auto formatting
