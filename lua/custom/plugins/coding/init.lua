return {
  --NOTE: For colorizing tailwind
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  --NOTE: Print Debugger
  --
  -- {
  --   'gaelph/logsitter.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   config = function()
  --     -- require('logsitter').log()
  --     -- vim.api.nvim_create_augroup('LogSitter', { clear = true })
  --     -- vim.api.nvim_create_autocmd('FileType', {
  --     --   group = 'Logsitter',
  --     --   pattern = 'javascript,go,lua',
  --     --   callback = function()
  --     --     vim.keymap.set('n', '<localleader>lg', function()
  --     --       require('logsitter').log()
  --     --     end)
  --     --   end,
  --     -- })
  --   end,
  -- },
  {
    'andrewferrier/debugprint.nvim',
    opts = {
      keymaps = {
        normal = {
          plain_below = 'g?p',
          plain_above = 'g?P',
          variable_below = 'g?v',
          variable_above = 'g?V',
          variable_below_alwaysprompt = nil,
          variable_above_alwaysprompt = nil,
          textobj_below = 'g?o',
          textobj_above = 'g?O',
          toggle_comment_debug_prints = nil,
          delete_debug_prints = nil,
        },
        visual = {
          variable_below = 'g?v',
          variable_above = 'g?V',
        },
      },
      commands = {
        toggle_comment_debug_prints = 'ToggleCommentDebugPrints',
        delete_debug_prints = 'DeleteDebugPrints',
      },
    },
    dependencies = {
      'echasnovski/mini.nvim', -- Needed to enable :ToggleCommentDebugPrints for NeoVim <= 0.9
      'nvim-treesitter/nvim-treesitter', -- Needed to enable treesitter for NeoVim 0.8
    },
    -- Remove the following line to use development versions,
    -- not just the formal releases
    version = '*',
  },
}
