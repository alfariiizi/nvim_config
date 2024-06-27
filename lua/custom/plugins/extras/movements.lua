local prefix = '<leader>f'

return {
  --NOTE: Hop movement
  {
    'smoka7/hop.nvim',
    version = '*',
    lazy = false,
    keys = {
      {
        prefix .. 'c',
        '<cmd>HopChar1AC<CR>',
        mode = 'n',
        desc = 'Hop Word after cursor',
      },
      {
        prefix .. 'C',
        '<cmd>HopChar1BC<CR>',
        mode = 'n',
        desc = 'Hop Word before cursor',
      },
      {
        prefix .. 'w',
        '<cmd>HopWord<CR>',
        mode = 'n',
        desc = 'Hop Word (Anywhere)',
      },
      {
        prefix .. 'd',
        '<cmd>HopWordCurrentLine<CR>',
        mode = 'n',
        desc = 'Hop Word Current Line (Anywhere)',
      },
      {
        prefix .. 'l',
        '<cmd>HopLineStart<CR>',
        mode = 'n',
        desc = 'Hop Line Start',
      },
    },
    opts = {
      -- keys = 'hklyuiopnm,qwertzxcvbasdgjf;',
      keys = 'etovsqpdygfblzhckixuran',
    },
    config = function(_, opts)
      local hop = require 'hop'
      local directions = require('hop.hint').HintDirection

      hop.setup(opts)

      vim.keymap.set('', 'f', function()
        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
      end, { remap = true, desc = 'Forward F Mode' })
      vim.keymap.set('', 'F', function()
        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
      end, { remap = true, desc = 'Backward F Mode' })
      vim.keymap.set('', 't', function()
        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
      end, { remap = true, desc = 'Forward T Mode' })
      vim.keymap.set('', 'T', function()
        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
      end, { remap = true, desc = 'Backward T Mode' })
    end,
  },

  --NOTE: Flash
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    -- stylua: ignore
    keys = {
      { prefix .. "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { prefix .. "t", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { prefix .. "r", mode = { "n", "o" }, function() require("flash").remote() end, desc = "Remote Flash",  },
      { prefix .. "S", mode = { "n", "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
    ---@type Flash.Config
    opts = {
      labels = 'etovxqpdygfblzhckisuran',
      modes = {
        -- disable flash for `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
          enabled = false,
        },
      },
      label = {
        -- allow uppercase labels
        uppercase = false,
        style = 'overlay', ---@type "eol" | "overlay" | "right_align" | "inline"
        rainbow = {
          enabled = false,
          -- number between 1 and 9
          shade = 5,
        },
      },
    },
  },
}
