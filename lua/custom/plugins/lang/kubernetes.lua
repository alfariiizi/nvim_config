return {
  {
    'ramilito/kubectl.nvim',
    config = function()
      require('kubectl').setup()
      -- vim.keymap.set('n', '<leader>k', '<cmd>lua require("kubectl").toggle({ tab: boolean })<cr>', { noremap = true, silent = true })
    end,
  },
  {
    dir = vim.fn.stdpath 'config' .. '/lua/custom/module',
    config = function()
      require('custom.module.kubernetes-utils').setup {
        -- Optional custom configuration
        -- kubectl_path = "/usr/local/bin/kubectl", -- Custom kubectl path if needed
        -- default_namespace = "development",       -- Your preferred default namespace
        -- keymaps = {
        --   apply = "<leader>ka",                 -- Customize keymaps if needed
        -- }
      }
    end,
  },
}
