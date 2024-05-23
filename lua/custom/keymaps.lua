-- If there are overlapping keymaps, this keymap will win

local set = vim.keymap.set

set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = '[L]azy Menu' })
set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite file (Save file)' })

set('n', '<C-u>', '<C-u>zz')
set('n', '<C-d>', '<C-d>zz')
set('n', 'G', 'Gzz')

set('n', '<leader>;', '<cmd>e ./.env<CR>', { desc = 'Env File' })
set('n', '<leader>,', '<C-^>', { desc = 'Open last opened file' })

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
