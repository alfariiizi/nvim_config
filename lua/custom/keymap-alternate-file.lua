-- [[ Switch to recent active buffer ]]

-- =========== [ Explanation ] ===========
-- 1. Buffer History Management: The buffer_history table keeps track of the order of buffer usage. It updates whenever you switch buffers (BufEnter).
-- 2. Updating Buffer History: The update_buffer_history function adds the current buffer to the start of buffer_history and removes any previous entries of the same buffer.
-- 3. Switching Function: The switch_to_last_available_buffer function looks for the first available (loaded and not current) buffer in the history to switch to. It starts checking from the second item because the first item will be the current buffer.
-- 4. Key Mapping: The key mapping uses Neovim's Lua API to set up the shortcut (Ctrl-^), calling the Lua function directly.

-- =========== [ Credit ] ===========
-- - ChatGPT-4

-- =========== [ Code ] ===========

-- Initialize the buffer history table
local buffer_history = {}

-- Function to update buffer history
local function update_buffer_history()
  local current_buf = vim.api.nvim_get_current_buf()
  -- Remove current buffer if it's already in the history to prevent duplicates
  for i, buf in ipairs(buffer_history) do
    if buf == current_buf then
      table.remove(buffer_history, i)
      break
    end
  end
  -- Insert current buffer at the start of the list
  table.insert(buffer_history, 1, current_buf)
end

-- Attach the update function to the BufEnter event
vim.api.nvim_create_autocmd('BufEnter', {
  callback = update_buffer_history,
})

-- Function to switch to the last available buffer
local function switch_to_last_available_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  for i = 2, #buffer_history do
    local buf = buffer_history[i]
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= current_buf then
      vim.api.nvim_set_current_buf(buf)
      return
    end
  end
  print 'No suitable alternate buffer found'
end

-- Map Ctrl-^ to the new function using Lua
vim.keymap.set('n', '<leader>,', '', { noremap = true, callback = switch_to_last_available_buffer })
