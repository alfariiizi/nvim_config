return {
  --NOTE: Autocompletion
  {
    'hrsh7th/nvim-cmp',
    -- event = 'InsertEnter', -- I need the cmp-cmdline. So the nvim-cmp need to load on start
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = {
          'antosha417/nvim-lsp-file-operations',
          opts = {},
        },
      },
      'hrsh7th/cmp-path',

      -- For colorizing tailwind in completion popup
      { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },

      -- For react snippet
      {
        'mlaursen/vim-react-snippets',
        config = function()
          require('vim-react-snippets').lazy_load()
        end,
      },

      -- For autocompletion on cmdline
      { 'hrsh7th/cmp-cmdline' },
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          -- ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<A-j>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          -- ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<A-k>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<Tab>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        -- Get this solution from: https://github.com/hrsh7th/nvim-cmp/issues/809
        mapping = cmp.mapping.preset.cmdline {
          ['<Tab>'] = cmp.mapping.confirm { select = true },
          ['<A-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
          ['<A-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        },
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
      })
    end,
  },

  -- {
  --   'gelguy/wilder.nvim',
  --   config = function()
  --     local wilder = require 'wilder'
  --     wilder.setup { modes = { ':', '/', '?' } }
  --
  --     -- Airline/Lightline theme
  --     wilder.set_option(
  --       'renderer',
  --       wilder.wildmenu_renderer(
  --         -- use wilder.wildmenu_lightline_theme() if using Lightline
  --         wilder.wildmenu_airline_theme {
  --           -- highlights can be overriden, see :h wilder#wildmenu_renderer()
  --           highlights = { default = 'StatusLine' },
  --           highlighter = wilder.basic_highlighter(),
  --           separator = ' · ',
  --         }
  --       )
  --     )
  --
  --     -- Popupmenu renderer
  --     wilder.set_option(
  --       'renderer',
  --       wilder.renderer_mux {
  --         [':'] = wilder.popupmenu_renderer {
  --           highlighter = wilder.basic_highlighter(),
  --         },
  --         ['/'] = wilder.wildmenu_renderer {
  --           highlighter = wilder.basic_highlighter(),
  --         },
  --       }
  --     )
  --     -- Pumblend is "Opacity"
  --     wilder.set_option(
  --       'renderer',
  --       wilder.popupmenu_renderer {
  --         pumblend = 20,
  --       }
  --     )
  --
  --     -- Popupmenu borders
  --     wilder.set_option(
  --       'renderer',
  --       wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
  --         highlights = {
  --           border = 'Normal', -- highlight to use for the border
  --         },
  --         -- 'single', 'double', 'rounded' or 'solid'
  --         -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
  --         border = 'rounded',
  --       })
  --     )
  --
  --     -- Devicons for popupmenu
  --     wilder.set_option(
  --       'renderer',
  --       wilder.popupmenu_renderer {
  --         highlighter = wilder.basic_highlighter(),
  --         left = { ' ', wilder.popupmenu_devicons() },
  --         right = { ' ', wilder.popupmenu_scrollbar() },
  --       }
  --     )
  --
  --     -- Better highlight (It have performance issue)
  --     -- wilder.set_option(
  --     --   'renderer',
  --     --   wilder.popupmenu_renderer {
  --     --     highlighter = {
  --     --       wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
  --     --       wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
  --     --       -- at https://github.com/romgrk/fzy-lua-native
  --     --     },
  --     --     highlights = {
  --     --       accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
  --     --     },
  --     --   }
  --     -- )
  --   end,
  -- },
}
