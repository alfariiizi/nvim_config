-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Kubernetes YAML ]]

-- Function to check if a file contains Kubernetes keywords
local function is_kubernetes_yaml(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false) -- Read first 10 lines
  local content = table.concat(lines, '\n')
  return content:match 'apiVersion:' and content:match 'kind:'
end

-- Auto-detect Kubernetes files and apply the schema
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*.yaml,*.yml',
  callback = function(args)
    local bufnr = args.buf
    if is_kubernetes_yaml(bufnr) then
      vim.lsp.buf_notify(bufnr, 'workspace/didChangeConfiguration', {
        settings = {
          yaml = {
            schemas = {
              ['https://json.schemastore.org/kubernetes'] = '*.yaml',
            },
          },
        },
      })
    end
  end,
})
