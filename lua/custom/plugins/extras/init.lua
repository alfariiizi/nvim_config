return {
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
  --
  -- # Usage:
  -- Basic usage:
  -- - select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
  -- - create cursors vertically with Ctrl-Down/Ctrl-Up
  -- - select one character at a time with Shift-Arrows
  -- - press n/N to get next/previous occurrence
  -- - press [/] to select next/previous cursor
  -- - press q to skip current and get next occurrence
  -- - press Q to remove current cursor/selection
  -- - start insert mode with i,a,I,A
  {
    'mg979/vim-visual-multi',
  },
}
