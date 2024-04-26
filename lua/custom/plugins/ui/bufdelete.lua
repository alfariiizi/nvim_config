return {
  'famiu/bufdelete.nvim',
  config = function()
    local bufdelete = require 'bufdelete'
    vim.keymap.set('n', '<leader>q', function()
      bufdelete.bufdelete(0, true)
    end, { desc = '[Q]uit buffer (Bufdelete)' })
  end,
}
