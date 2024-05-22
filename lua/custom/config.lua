-- [Fold]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- [Top winbar status line]
-- vim.opt.winbar = '%=%m %f'

-- Function to get the current file path
function GetFormattedFilePath()
  local file_path = vim.fn.expand '%:p'
  local file_name = vim.fn.expand '%:t'
  local relative_path = vim.fn.fnamemodify(file_path, ':.')
  local directory_path = vim.fn.fnamemodify(relative_path, ':h')
  return string.format('%s (%s)', file_name, directory_path)
end

-- Set the winbar background color
vim.api.nvim_set_hl(0, 'WinBarCustom', { bg = '#ebdbb2', fg = '#272737', bold = true })

-- Set the winbar to use the current file path
vim.o.winbar = '%{%v:lua.GetFormattedFilePath()%}'
