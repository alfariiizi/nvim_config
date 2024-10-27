return {
  'ms-jpq/chadtree',
  branch = 'chad',
  build = 'python3 -m chadtree deps',
  cmd = 'CHADopen', -- Lazy-load on command
  keys = {
    { '<leader>ue', '<cmd>CHADopen<cr>', desc = '[U]I: [E]xplorer (CHADTree)' },
  },
  config = function()
    --     let g:chadtree_settings = {
    --    "view.open_direction": "right",
    -- }
    local chadtree_settings = {
      view = {
        open_direction = 'right',
        width = 36,
        window_options = {
          cursorline = true,
          number = false,
          relativenumber = false,
          signcolumn = 'no',
          winfixwidth = true,
          wrap = true,
        },
      },
    }
    vim.api.nvim_set_var('chadtree_settings', chadtree_settings)
  end,
}
