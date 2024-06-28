local prefix = '<leader>n'

return {
  'JellyApple102/flote.nvim',
  config = function()
    -- defaults
    require('flote').setup {
      q_to_quit = true,
      window_style = '', -- 'minimal' | '' (empty string)
      window_border = 'double', -- 'solid' | 'single' | 'double'
      window_title = true,
      notes_dir = vim.fn.stdpath 'cache' .. '/flote',
      -- notes_dir = '~/notes/flote',
      files = {
        global = 'flote-global.md',
        cwd = function()
          return vim.fn.getcwd()
        end,
        file_name = function(cwd)
          local base_name = vim.fs.basename(cwd)
          local parent_base_name = vim.fs.basename(vim.fs.dirname(cwd))
          return parent_base_name .. '_' .. base_name .. '.md'
        end,
      },
    }

    require('which-key').register {
      [prefix] = { name = '[N]otes', _ = 'which_key_ignore' },
    }
    vim.keymap.set('n', prefix .. 'n', '<cmd>Flote<cr>', { desc = 'Project Notes' })
    vim.keymap.set('n', prefix .. 'g', '<cmd>Flote global<cr>', { desc = 'Global Notes' })
    vim.keymap.set('n', prefix .. 'm', '<cmd>Flote manage<cr>', { desc = 'Manage Notes' })
  end,
}
