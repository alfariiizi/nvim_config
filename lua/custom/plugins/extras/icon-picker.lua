local leader = '<leader>i'
local desc_prefix = '[I]con: '

return {
  'ziontee113/icon-picker.nvim',
  keys = {
    { leader .. 'i', mode = { 'n' }, '<cmd>IconPickerNormal<cr>', desc = desc_prefix .. '[I]con Picker' },
    { leader .. 'y', mode = { 'n' }, '<cmd>IconPickerYank<cr>', desc = desc_prefix .. '[Y]nk Selected Icon into Register' },
  },
  config = function()
    require('icon-picker').setup { disable_legacy_commands = true }
    -- local opts = { noremap = true, silent = true }
    -- vim.keymap.set('i', '<C-i>', '<cmd>IconPickerInsert<cr>', opts)
  end,
}
