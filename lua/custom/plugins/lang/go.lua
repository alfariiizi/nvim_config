return {
  {
    'zgs225/gomodifytags.nvim',
    cmd = { 'GoAddTags', 'GoRemoveTags', 'GoInstallModifyTagsBin' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('gomodifytags').setup {
        override = false,
        skip_unexported = false,
        sort = true,
        transform = 'camelcase',
      } -- Optional: You can add any specific configuration here if needed.
    end,
  },
}
