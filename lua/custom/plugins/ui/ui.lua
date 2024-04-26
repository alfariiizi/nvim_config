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
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
  },

  {
    'Bekaboo/dropbar.nvim',
    enabled = false, -- I disable it because it need neovim version >= 10
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      -- optional, but required for fuzzy finder support
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      require('dropbar').setup()
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
          margin = { horizontal = 0 },
          overlap = {
            borders = true,
            winbar = true,
            tabline = true,
          },
          -- placement = {
          --   vertical = 'bottom',
          -- },
        },
        render = function(props)
          local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t') -- from incline docs (it get the name of file)
          local path = vim.fn.fnamemodify(vim.fn.expand '%:h', ':p:~:.') -- thanks to: https://www.reddit.com/r/neovim/comments/q2s3t1/comment/hfnevrm/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
          -- local filename = vim.api.nvim_buf_get_name(props.buf)
          local filename = path .. name
          local modified = vim.bo[props.buf].modified
          return {
            ' ',
            filename,
            modified and { ' *', guifg = '#888888', gui = 'bold' } or '',
            ' ',
            guibg = 'auto',
            guifg = '#eeeeee',
          }
        end,
      }
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },
}
