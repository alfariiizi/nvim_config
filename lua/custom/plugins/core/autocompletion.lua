local splitstring = function(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

return {
  --NOTE: Autocompletion
  {
    'hrsh7th/nvim-cmp',
    branch = 'main',
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

      -- Vscode-like pictograms for neovim lsp completion items
      'onsails/lspkind.nvim',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        performance = {
          debounce = 0,
          throttle = 0,
          -- fetching_timeout = 100,
          fetching_timeout = 1000,
          -- confirm_resolve_timeout = 80,
          confirm_resolve_timeout = 800,
          async_budget = 500,
          max_view_entries = 300,

          -- Others
          -- debounce = 500,
          -- throttle = 550,
          -- fetching_timeout = 80,
        },
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
          -- add copilot source
          -- { name = 'copilot', group_index = 2 },
          { name = 'nvim_lsp', keyword_length = 2, max_item_count = 100 },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'lab.quick_data', keyword_length = 4 },
          { name = 'otter' },
        },
        formatting = {
          fields = {
            cmp.ItemField.Abbr,
            cmp.ItemField.Kind,
            cmp.ItemField.Menu,
          },
          expandable_indicator = true,
          format = function(entry, vim_item)
            local item_with_kind = require('lspkind').cmp_format {
              -- mode = 'symbol', -- show only symbol annotations
              -- max_width = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              maxwidth = function()
                return math.floor(0.45 * vim.o.columns)
              end,
              ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
              show_labelDetails = true, -- show labelDetails in menu. Disabled by default
              -- symbol_map = {
              -- Copilot = '',
              -- },
              -- before = function(entry, vim_item)
              --   -- vim_item.menu = ' ' .. (({ nvim_lsp = 'lsp', cmp_git = 'git' })[entry.source.name] or entry.source.name) .. ': ' .. vim_item.kind
              --   -- vim_item.kind = nil
              --
              --   -- Show paths for auto imports with neovim nvim-cmp
              --   -- Solution: https://stackoverflow.com/questions/72668920/how-to-show-paths-for-auto-imports-with-neovim-nvim-cmp
              --   -- local completion_context = entry.completion_item.detail or entry.data.entry_names[1].data.moduleSpecifier or ''
              --   local completion_context = entry.completion_item.detail
              --   -- print('DEBUGPRINT[4]: autocompletion.lua:155: entry.completion_item=' .. vim.inspect(entry.completion_item))
              --   DEBUGGING = entry.completion_item
              --   if completion_context ~= nil and completion_context ~= '' then
              --     -- vim_item.menu = entry.completion_item.detail
              --     local cwd = string.sub(vim.fn.getcwd(), 2)
              --     local home_dir = string.sub(vim.fn.expand '$HOME', 2)
              --     if string.find(completion_context, cwd) then
              --       completion_context = string.sub(completion_context, string.len(cwd) + 2, string.len(completion_context))
              --     elseif string.find(completion_context, home_dir) then
              --       completion_context = '~/' .. string.sub(completion_context, string.len(home_dir) + 2, string.len(completion_context))
              --       -- else
              --       --   completion_context = '/' .. completion_context
              --     end
              --
              --     local truncated_context = string.sub(completion_context, 1, 30)
              --     if truncated_context ~= completion_context then
              --       truncated_context = truncated_context .. '...'
              --     end
              --     vim_item.menu = truncated_context
              --   else
              --     vim_item.menu = ({
              --       nvim_lsp = '[LSP]',
              --       luasnip = '[Snippet]',
              --       buffer = '[Buffer]',
              --       path = '[Path]',
              --     })[entry.source.name]
              --   end
              --
              --   vim_item.menu_hl_group = 'CmpItemAbbr'
              --   return vim_item
              -- end,
            }(entry, vim_item)

            -- local completion_context = entry.completion_item.detail

            -- local firstline = splitstring(entry:get_completion_item().detail, '\n')
            -- DEBUGGING = firstline

            -- if completion_context ~= nil and completion_context ~= '' then
            --   local truncated_context = string.sub(completion_context, 1, 30)
            --   if truncated_context ~= completion_context then
            --     truncated_context = truncated_context .. ' ...'
            --   end
            --   item_with_kind.menu = item_with_kind.menu .. ' ' .. truncated_context
            -- end

            -- DEBUGGING = entry:get_completion_item()
            -- if entry:get_completion_item().detail ~= nil then
            --   local lastIndex = entry:get_completion_item().detail:find '\n' or 1
            --   -- local _, *first = entry:get_completion_item().detail:find(' from ') or 18
            --   DEBUGGING = entry:get_completion_item().detail:sub(18, lastIndex)
            --   item_with_kind.menu = entry:get_completion_item().detail:sub(18, lastIndex)
            -- end

            -- DEBUGGING = entry:get_completion_item().detail
            -- DEBUGGING = entry.source.source
            -- if entry.completion_item.data ~= nil and entry.completion_item.data.entryNames then
            --   DEBUGGING = entry.completion_item.data.entryNames[1].source
            -- end

            item_with_kind.menu_hl_group = 'CmpItemAbbr'
            return item_with_kind
          end,
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
          -- ['<Tab>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping(cmp.mapping.confirm { select = true }, { 'i', 'c' }),
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
