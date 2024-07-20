return {
  'backdround/global-note.nvim',
  config = function()
    require('global-note').setup {
      filename = 'global.md',
      directory = '~/notes/',

      additional_presets = {
        projects = {
          filename = 'projects-to-do.md',
          title = 'List of projects',
          command_name = 'ProjectsNote',
          -- All not specified options are used from the root.
        },

        food = {
          filename = 'want-to-eat.md',
          title = 'List of food',
          command_name = 'FoodNote',
          -- All not specified options are used from the root.
        },
      },
    }

    -- Functions to toggle notes:
    -- require('global-note').toggle_note()
    -- require('global-note').toggle_note 'projects'
    -- require('global-note').toggle_note 'food'

    -- Commands to toggle notes (they are generated by command_name field):
    -- :GlobalNote -- by default
    -- :ProjectsNote
    -- :FoodNote
  end,
}