-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      triggers_nowait = {
        -- marks
        ';',
        '`',
        "'",
        'g`',
        "g'",
        -- registers
        '"',
        '<c-r>',
        -- spelling
        'z=',
      },
    },
    config = function(_, opts) -- This is the function that runs, AFTER loading
      require('which-key').setup(opts)

      -- Document existing key chains
      require('which-key').register {
        -- [Leader]
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>C'] = { name = '[C]onfiguration', _ = 'which_key_ignore' },
        ['<leader>m'] = { name = '[M]ason', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Fi[X] Wrong (Trouble)', _ = 'which_key_ignore' },
        ['<leader>u'] = { name = '[U]I', _ = 'which_key_ignore' },

        -- [G]
        ['g?'] = { name = 'Print Debug', _ = 'which_key_ignore' },

        -- [F]
        ['<leader>f'] = { name = 'Movement', _ = 'which_key_ignore' },

        -- [Local]
        ['<localLeader>l'] = { name = '[L]atex', _ = 'which_key_ignore' },
        ['<localLeader>o'] = { name = '[O]bsidian', _ = 'which_key_ignore' },
      }
    end,
  },
}
