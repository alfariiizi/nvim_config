return {
  'AckslD/nvim-FeMaco.lua',
  enabled = false,
  keys = {
    {
      '<leader>ce',
      mode = { 'n' },
      function()
        require('femaco.edit').edit_code_block()
      end,
      desc = '[C]ode [E]dit (FeMaco)',
    },
  },
  opts = {},
}
