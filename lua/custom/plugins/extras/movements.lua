return {
  --NOTE: Hop movement
  --
  -- {
  --   'smoka7/hop.nvim',
  --   version = '*',
  --   keys = {
  --     {
  --       'f',
  --       '<cmd>HopChar1AC<CR>',
  --       mode = 'n',
  --       desc = 'Hop Word after cursor',
  --     },
  --     {
  --       'F',
  --       '<cmd>HopChar1BC<CR>',
  --       mode = 'n',
  --       desc = 'Hop Word before cursor',
  --     },
  --   },
  --   opts = {
  --     -- keys = 'hklyuiopnm,qwertzxcvbasdgjf;',
  --   },
  -- },

  --NOTE: Flash
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    -- stylua: ignore
    keys = {
      { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash",  },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    ---@type Flash.Config
    opts = {
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
