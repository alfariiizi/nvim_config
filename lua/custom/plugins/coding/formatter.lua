return {
  --NOTE: Autoformat
  {
    'stevearc/conform.nvim',
    event = { 'LspAttach', 'BufReadPost', 'BufNewFile' },
    lazy = false,
    -- keys = {
    --   {
    --     '<leader>cf',
    --     function()
    --       require('conform').format { async = true, lsp_fallback = true }
    --     end,
    --     mode = '',
    --     desc = '[F]ormat buffer',
    --   },
    -- },
    config = function()
      local conform = require 'conform'

      conform.setup {
        notify_on_error = false,
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          javascript = { 'prettierd', 'prettier' },
          typescript = { 'prettierd', 'prettier' },
          javascriptreact = { 'prettierd', 'prettier' },
          typescriptreact = { 'prettierd', 'prettier' },
          svelte = { 'prettierd', 'prettier' },
          css = { 'prettierd', 'prettier' },
          html = { 'prettierd', 'prettier' },
          json = { 'prettierd', 'prettier' },
          yaml = { 'prettierd', 'prettier' },
          ['markdown'] = { 'prettierd', 'prettier', 'markdownlint', 'markdown-toc' },
          ['markdown.mdx'] = { 'prettierd', 'prettier', 'markdownlint', 'markdown-toc' },
          graphql = { 'prettierd', 'prettier' },
          tex = { 'latexindent' },
          plaintex = { 'latexindent' },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 3000,
        },
      }

      conform.format { async = true, lsp_fallback = true }

      -- Customise the default "prettier" command to format Markdown files as well
      conform.formatters.prettierd = {
        prepend_args = { '--prose-wrap', 'always' },
      }
      conform.formatters.prettier = {
        prepend_args = { '--prose-wrap', 'always' },
      }

      vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = '[F]ormat buffer' })
    end,

    -- opts = {
    --   format = {
    --     -- It's from lazyvim
    --     timeout_ms = 3000,
    --     async = false, -- not recommended to change
    --     quiet = false, -- not recommended to change
    --     lsp_fallback = true, -- not recommended to change
    --   },
    --   notify_on_error = false,
    --   format_on_save = function(bufnr)
    --     -- Disable "format_on_save lsp_fallback" for languages that don't
    --     -- have a well standardized coding style. You can add additional
    --     -- languages here or re-enable it for the disabled ones.
    --     local disable_filetypes = { c = true, cpp = true }
    --     return {
    --       timeout_ms = 500,
    --       lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --     }
    --   end,
    --   ---@type table<string, conform.FormatterUnit[]>
    --   formatters_by_ft = {
    --     lua = { { 'stylua' } },
    --     -- Conform can also run multiple formatters sequentially
    --     python = { { 'isort', 'black' } },
    --     --
    --     -- You can use a sub-list to tell conform to run *until* a formatter
    --     -- is found.
    --     javascript = { { 'prettierd', 'prettier' } },
    --     typescript = { { 'prettierd', 'prettier' } },
    --     javascriptreact = { { 'prettierd', 'prettier' } },
    --     typescriptreact = { { 'prettierd', 'prettier' } },
    --     svelte = { { 'prettierd', 'prettier' } },
    --     css = { { 'prettierd', 'prettier' } },
    --     html = { { 'prettierd', 'prettier' } },
    --     json = { { 'prettierd', 'prettier' } },
    --     yaml = { { 'prettierd', 'prettier' } },
    --     ['markdown'] = { { 'prettierd', 'prettier' }, 'markdownlint', 'markdown-toc' },
    --     ['markdown.mdx'] = { { 'prettierd', 'prettier' }, 'markdownlint', 'markdown-toc' },
    --     graphql = { { 'prettierd', 'prettier' } },
    --     tex = { { 'latexindent' } },
    --     plaintex = { { 'latexindent' } },
    --   },
    -- },
  },
}
