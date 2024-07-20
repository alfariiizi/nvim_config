-- local moc_list = {
--   'dev',
--   'science',
-- }

local function createNoteWithDefaultTemplate()
  local TEMPLATE_FILENAME = 'note-template'
  local obsidian = require('obsidian').get_client()
  local utils = require 'obsidian.util'

  -- prevent Obsidian.nvim from injecting it's own frontmatter table
  obsidian.opts.disable_frontmatter = true

  -- prompt for note title
  -- @see: borrowed from obsidian.command.new
  local note
  local title = utils.input 'Enter title or path (optional): '
  if not title then
    return
  elseif title == '' then
    title = nil
  end

  note = obsidian:create_note { title = title, no_write = true }

  if not note then
    return
  end
  -- open new note in a buffer
  obsidian:open_note(note, { sync = true })
  -- NOTE: make sure the template folder is configured in Obsidian.nvim opts
  obsidian:write_note_to_buffer(note, { template = TEMPLATE_FILENAME })
  -- hack: delete empty lines before frontmatter; template seems to be injected at line 2
  vim.api.nvim_buf_set_lines(0, 0, 1, false, {})
end

return {
  {
    'oflisback/obsidian-bridge.nvim',
    enabled = false,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('obsidian-bridge').setup {
        obsidian_server_address = 'http://127.0.0.1:27123',
        scroll_sync = true,
      }
    end,
    event = {
      'BufReadPre *.md',
      'BufNewFile *.md',
    },
    lazy = true,
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    enabled = false,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',

      -- see below for full list of optional dependencies 👇
    },

    init = function()
      vim.api.nvim_create_user_command('ObsidianNewFromTemplate', function()
        vim.cmd 'ObsidianNew'
        vim.cmd 'normal! G' -- go to end of file
        vim.cmd 'normal! o' -- create new line
        vim.cmd 'ObsidianTemplate'
      end, {})
    end,

    keys = {
      { '<localleader><localleader>', '<cmd>ObsidianSearch<cr>', desc = 'Obsidian Search' },
      { '<localleader><cr>', '<cmd>ObsidianToggleCheckbox<cr>', desc = 'Obsidian Toggle Checkbox' },
      { '<localleader>on', '<cmd>ObsidianNew<cr>', desc = '[O]bsidian [N]ew Note' },
      { '<localleader>oN', '<cmd>ObsidianNewFromTemplate<cr>', desc = '[O]bsidian [N]ew Note From Template' },
      { '<localleader>ob', '<cmd>ObsidianBacklinks<cr>', desc = '[O]bsidian [B]ackliks' },
      { '<localleader>of', '<cmd>ObsidianLink<cr>', desc = '[O]bsidian [F]orwardlinks' },
      { '<localleader>oT', '<cmd>ObsidianTags<cr>', desc = '[O]bsidian [T]ags' },
      { '<localleader>ot', '<cmd>ObsidianTemplate<cr>', desc = '[O]bsidian [T]emplate' },
      { '<localleader>ow', '<cmd>ObsidianWorkspace<cr>', desc = '[O]bsidian [W]orkspaces' },
    },

    opts = {
      workspaces = {
        ---@type obsidian.Workspace
        {
          name = 'personal',
          path = '~/OneDrive_alfarizi/Home (Vault)',
        },
        {
          name = 'quick-notes',
          path = '~/notes',
        },
      },

      -- see below for full list of options 👇

      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      ---@type obsidian.config.CompletionOpts
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      ---@type obsidian.config.MappingOpts
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gd'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        -- ['<leader>ch'] = {
        --   action = function()
        --     return require('obsidian').util.toggle_checkbox()
        --   end,
        --   opts = { buffer = true },
        -- },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      -- new_notes_location = (function()
      --   local moc = vim.ui.select(moc_list, {}, function(select)
      --     return select
      --   end)
      --   return moc
      -- end)(),
      --

      ---@type obsidian.config.NewNotesLocation
      new_notes_location = 'notes_subdir',

      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = 'Notes',

      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
          local title_lowecase = note.title:lower()
          local title_first_letter_upper = title_lowecase:sub(1, 1):upper() .. title_lowecase:sub(2)
          if title_first_letter_upper ~= note.title then
            note:add_alias(title_first_letter_upper)
          end
          if title_lowecase ~= note.title then
            note:add_alias(title_lowecase)
          end
        end

        local out = {
          category = 'Notes',
          id = note.id,
          title = note.title,
          aliases = note.aliases,
          ['created-date'] = note.date,
          tags = note.tags,
        }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. '-' .. suffix
      end,

      templates = {
        subdir = 'templates-obsidian-nvim',
        date_format = '%Y-%m-%d-%a',
        time_format = '%H:%M',
        substitutions = {
          yesterday = function()
            return os.date('%Y-%m-%d', os.time() - 86400)
          end,
        },
      },

      -- Specify how to handle attachments.
      ---@type obsidian.config.AttachmentsOpts
      attachments = {
        confirm_img_paste = true,
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = 'Notes/assets/imgs', -- This is the default
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format('![%s](%s)', path.name, path)
        end,
      },
    },

    config = function(_, opts)
      require('obsidian').setup(opts)

      -- Issue: https://github.com/epwalsh/obsidian.nvim/issues/286
      vim.opt_local.conceallevel = 2

      -- Issue: https://github.com/epwalsh/obsidian.nvim/issues/467
      -- vim.keymap.set('n', '<localleader>oN', createNoteWithDefaultTemplate, { desc = '[N]ew [N]ote From Template' })
    end,
  },
}
