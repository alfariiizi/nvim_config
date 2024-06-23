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

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      local colors = {
        blue = '#80a0ff',
        cyan = '#79dac8',
        black = '#080808',
        white = '#c6c6c6',
        red = '#ff5189',
        violet = '#d183e8',
        grey = '#303030',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white },
        },

        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.white },
        },
      }

      local opts = {
        options = {
          theme = bubbles_theme,
          disabled_filetypes = {
            statusline = { 'dashboard', 'alpha', 'starter', 'neo-tree' },
            winbar = { 'dashboard', 'alpha', 'starter', 'neo-tree' },
          },
          component_separators = { left = ' ', right = ' ' },
          -- section_separators = { left = '', right = '' },
          section_separators = '',
        },
        winbar = {
          lualine_b = {
            -- separator = { left = '', right = '' },
            -- right_separator = '',
            -- left_padding = 2,
            {
              'filetype',
              icon_only = true,
              separator = { left = '', right = '' },
              padding = { right = 1, left = 1 },
            },
            {
              'filename',
              separator = { left = '', right = '' },
              padding = { right = 1, left = 0 },
            },
          },
          lualine_y = {
            {
              function()
                local file_path = vim.fn.expand '%:p'
                local relative_path = vim.fn.fnamemodify(file_path, ':.')
                local directory_path = vim.fn.fnamemodify(relative_path, ':h')
                return '  ' .. directory_path
              end,
              separator = { left = '', right = '' },
              -- color = {
              --   -- fg = '#b0b4ca',
              --   fg = colors.white,
              -- },
            },
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          -- lualine_c = { 'filename' },
          lualine_c = {},
          -- lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }

      return opts
    end,
  },
}
