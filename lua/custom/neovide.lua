if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.o.guifont = 'JetBrainsMono Nerd Font:h12' -- text below applies for VimScript
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = false

  -- [Animation]
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_animate_command_line = false

  -- [Keybinds]
  vim.api.nvim_set_keymap('v', '<C-S-c>', '"+y', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-S-v>', '"+p', { noremap = true })
  vim.api.nvim_set_keymap('v', '<C-S-v>', '"+p', { noremap = true })
  vim.api.nvim_set_keymap('c', '<C-S-v>', '<C-r>+', { noremap = true })
  vim.api.nvim_set_keymap('x', '<C-S-v>', '<C-r>+', { noremap = true })
  vim.api.nvim_set_keymap('i', '<C-S-v>', '<ESC>"+pa', { noremap = true })
  vim.api.nvim_set_keymap('t', '<C-S-v>', '<C-\\><C-n>"+pa', { noremap = true })
end
