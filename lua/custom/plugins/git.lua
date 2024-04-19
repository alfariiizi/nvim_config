return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git' },
  },

  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gl', '<cmd>LazyGit<cr>', desc = '[L]azyGit' },
    },
  },

  {
    'rbong/vim-flog',
    lazy = true,
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = {
      'tpope/vim-fugitive',
    },
    keys = {
      { '<leader>gv', '<cmd>Flog<CR>', desc = 'Git Graph [V]iew' },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
}
