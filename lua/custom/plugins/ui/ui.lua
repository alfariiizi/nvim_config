return {
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = true },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
    main = 'ibl',
  },

  --NOTE: Improve default vim.ui interfaces
  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  {
    'nvimdev/dashboard-nvim',
    enabled = false,
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
  },

  {
    'LunarVim/breadcrumbs.nvim',
    enabled = false,
    dependencies = {
      {
        'SmiteshP/nvim-navic',
        config = function()
          require('nvim-navic').setup {
            lsp = {
              auto_attach = true,
            },
          }
        end,
      },
    },
    config = function()
      require('breadcrumbs').setup()
    end,
  },
  {
    'b0o/incline.nvim',
    enabled = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    -- Optional: Lazy load Incline
    -- event = 'VeryLazy',
    config = function()
      require('incline').setup {
        window = {
          width = 'fit',
          padding = 0,
          margin = { vertical = 0 },
          placement = { horizontal = 'right', vertical = 'top' },
          overlap = {
            borders = false,
            winbar = true,
            tabline = false,
            statusline = false,
          },
        },
        -- highlight = {
        --   groups = {
        --     InclineNormal = { guibg = 'none' },
        --     InclineNormalNC = { guibg = 'none' },
        --   },
        -- },
        render = function(props)
          local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t') -- from incline docs (it get the name of file)
          local path = vim.fn.fnamemodify(vim.fn.expand '%:h', ':p:~:.') -- thanks to: https://www.reddit.com/r/neovim/comments/q2s3t1/comment/hfnevrm/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
          -- local filename = vim.api.nvim_buf_get_name(props.buf)
          local filename = path .. name
          local modified = vim.bo[props.buf].modified
          local hl = vim.api.nvim_get_hl(0, { name = 'NormalFloat', link = false })
          local bg = string.format('#bbbbbb', hl.bg)
          local fg = '#111111'
          -- return {
          --   ' ',
          --   filename,
          --   modified and { ' *', guifg = '#888888', gui = 'bold' } or '',
          --   ' ',
          --   guibg = 'auto',
          --   guifg = '#eeeeee',
          -- }
          return {
            -- { '', guifg = bg },
            {
              { ' ', filename, ' ' },
              guibg = bg,
              guifg = fg,
            },
            modified and { '* ', guibg = bg, guifg = '#B22222', gui = 'bold' } or '',
            -- { '', guifg = bg },
            guibg = bg,
            guifg = fg,
          }
        end,
      }
    end,
  },
}
