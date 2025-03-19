-- If there are overlapping keymaps, this keymap will win

-- [[ It's for long configuration keymap  ]]
require 'custom.keymap-alternate-file'

-- [[ It's for short configuration keymap  ]]

local set = vim.keymap.set
-- local del = vim.keymap.del

set('n', '<Esc>', '<cmd>nohlsearch<CR>')

set('n', ';', '<cmd>WhichKey `<cr>', { noremap = true })
set('n', ';;', '``', { noremap = true })

-- del('n', 'grr') -- reference
-- del('n', 'gra') -- code action
-- del('n', 'grn') -- rename

-- Diagnostic keymaps
-- set('n', '[d', function()
--   vim.diagnostic.jump { count = -1, float = true }
-- end, { desc = 'Go to previous [D]iagnostic message' })
-- set('n', ']d', function()
--   vim.diagnostic.jump { count = 1, float = true }
-- end, { desc = 'Go to next [D]iagnostic message' })
set('n', ']d', vim.diagnostic.goto_next)
set('n', '[d', vim.diagnostic.goto_prev)
set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

set('n', '<leader>uq', '<cmd>q<cr>', { desc = 'Close current window' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

set({ 'n', 'v' }, 'j', 'gj')
set({ 'n', 'v' }, 'k', 'gk')

set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = '[L]azy Menu' })
set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite file (Save file)' })

set('n', '<C-u>', '<C-u>zz')
set('n', '<C-d>', '<C-d>zz')
set('n', 'G', 'Gzz')

-- Paste will not affect register
-- Try it: Yank something   Select other thing (in visual mode)   Hit "p"   Select other thing   Hit "p" again.
set('x', 'p', '"_dP')

set('n', '<leader>;', '<cmd>e ./.env<CR>', { desc = 'Env File' })
-- set('n', '<leader>,', '<C-^>', { desc = 'Open last opened file' })
-- set('n', '<leader>,', '<leader>sb<cr>', { desc = 'Open last opened file' })

-- set('n', '<leader>,', function()
--   local current_buf = vim.api.nvim_get_current_buf()
--   local buffers = vim.fn.getbufinfo { buflisted = 1 }
--   for i = #buffers, 1, -1 do
--     if buffers[i].bufnr ~= current_buf then
--       vim.api.nvim_set_current_buf(buffers[i].bufnr)
--       return
--     end
--   end
-- end, { desc = 'Open last opened active buffer' })

set('n', '<leader>Cz', '<cmd>e $HOME/.zshrc<cr>', { desc = '[C]onfig: [Z]shrc' })
set('n', '<leader>Ct', '<cmd>e $HOME/.tmux.conf<cr>', { desc = '[C]onfig: [T]mux' })

set('n', '<leader>uw', '<cmd>set wrap!<cr>', { desc = '[U]I: [W]rap Toggle' })

set('n', '<leader>-', '<cmd>split<cr>', { desc = '[-] Split Horizontal' })
set('n', '<leader>|', '<cmd>vsplit<cr>', { desc = '[|] Split Vertical' })

set('n', '<leader>\\', '<cmd>:call delete(swapname("."))<cr>', { desc = 'Delete current swapfile' })

-- [Fold]
-- set('n', 'zR', require('ufo').openAllFolds)
-- set('n', 'zM', require('ufo').closeAllFolds)
-- set('n', 'zK', function()
--   local winid = require('ufo').peekFoldedLinesUnderCursor()
--   if not winid then
--     vim.lsp.buf.hover()
--   end
-- end, { desc = 'Peek fold' })

-- Function to delete all buffers except the 3 most recent ones
function DeleteOldBuffers()
  -- Get a list of buffers sorted by the last access time (most recent first)
  local buffers = vim.fn.getbufinfo { bufloaded = 1 }
  table.sort(buffers, function(a, b)
    return a.lastused > b.lastused
  end)

  -- Delete all buffers except the first 3 (most recent)
  for i = 4, #buffers do
    vim.cmd('Bdelete ' .. buffers[i].bufnr)
  end
end

-- Map the function to a command or a keybinding
vim.api.nvim_set_keymap('n', '<leader>bd', ':lua DeleteOldBuffers()<CR>', { noremap = true, silent = true })

-- [[ YAML ]]
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>yt', ':YAMLTelescope<CR>', { noremap = false })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>yl', ':!yamllint %<CR>', { noremap = true, silent = true })
