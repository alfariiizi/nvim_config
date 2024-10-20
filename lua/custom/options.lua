-- [[ Setting options ]]

-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

vim.opt.colorcolumn = '80'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 6

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- [[ Fold ]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- [[ Top winbar status line ]]
-- vim.opt.winbar = '%=%m %f'

-- -- Function to get the current file path
-- function GetFormattedFilePath()
--   local file_path = vim.fn.expand '%:p'
--   local file_name = vim.fn.expand '%:t'
--   local relative_path = vim.fn.fnamemodify(file_path, ':.')
--   local directory_path = vim.fn.fnamemodify(relative_path, ':h')
--   local formattedFilepath = string.format('%s (%s)', file_name, directory_path)
--   return '\n' .. formattedFilepath .. '\n'
-- end
--
-- -- Set the winbar background color
-- vim.api.nvim_set_hl(0, 'WinBarCustom', { bg = '#ebdbb2', fg = '#272737', bold = true })
--
-- -- Set the winbar to use the current file path
-- vim.o.winbar = '%{%v:lua.GetFormattedFilePath()%}'

-- @source: https://github.com/yetone/avante.nvim
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
