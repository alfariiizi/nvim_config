return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
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
        -- a = { fg = colors.black, bg = colors.violet },
        -- b = { fg = colors.white, bg = colors.grey },
        -- c = { fg = colors.white },
        a = { fg = colors.violet, bg = 'none' },
        b = { fg = colors.white, bg = 'none' },
        c = { fg = colors.white },
      },

      insert = { a = { fg = colors.blue, bg = 'none' } },
      visual = { a = { fg = colors.cyan, bg = 'none' } },
      replace = { a = { fg = colors.red, bg = 'none' } },

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
          statusline = { 'dashboard', 'alpha', 'starter', 'neo-tree', 'outline_1', 'Outline' },
          winbar = { 'dashboard', 'alpha', 'starter', 'neo-tree', 'outline_1', 'Outline' },
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
            -- separator = { left = '', right = '' },
            padding = { right = 1, left = 1 },
          },
          {
            'filename',
            -- separator = { left = '', right = '' },
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
            -- separator = { left = '', right = '' },
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
      inactive_sections = {
        lualine_a = {
          function()
            return 'INACTIVE'
          end,
        },
        lualine_c = {},
      },
      inactive_winbar = {
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
    }

    return opts
  end,
}
