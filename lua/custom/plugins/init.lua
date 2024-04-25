-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  --NOTE: Autopairs and autotags
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {
      autotag = {
        enable = true,
      },
    },
  },

  --NOTE: Neovim file explorer: edit your filesystem like a buffer
  --
  -- {
  --   'stevearc/oil.nvim',
  --   -- Optional dependencies
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   keys = {
  --     { 'n', '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  --   },
  --   opts = {},
  -- },

  --NOTE: Fold
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    -- Not works using keys
    -- keys = {
    -- }
    opts = {
      provider_selector = function()
        return { 'lsp', 'indent' }
      end,
    },
    config = function(_, opts)
      require('ufo').setup(opts)

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zK', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = 'Peek fold' })
    end,
  },

  {
    'nvim-pack/nvim-spectre',
    build = false,
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
  -- stylua: ignore
  keys = {
    { "<leader>sR", function() require("spectre").open() end, desc = "[S]earch and [R]eplace in Files (Spectre)" },
  },
  },

  --NOTE: Multiline (multi cursor) editing
  {
    'mg979/vim-visual-multi',
  },

  { import = 'custom.plugins.coding' },
  { import = 'custom.plugins.lang' },
  { import = 'custom.plugins.ui' },
}
