return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      -- recommended telescope native sorter
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  keys = {
    { '<leader>gf', function() require('telescope.builtin').git_files() end,   'Search [G]it [F]iles' },
    { '<leader>sd', function() require('telescope.builtin').diagnostics() end, '[S]earch [D]iagnostics' },
    { '<leader>sf', function() require('telescope.builtin').find_files() end,  '[S]earch [F]iles' },
    { '<leader>sg', function() require('telescope.builtin').live_grep() end,   '[S]earch by [G]rep' },
    { '<leader>sh', function() require('telescope.builtin').help_tags() end,   '[S]earch [H]elp' },
    { '<leader>sr', function() require('telescope.builtin').resume() end,      '[S]earch [R]esume' },
    { '<leader>ss', function() require('telescope.builtin').builtin() end,     '[S]earch [S]elect Telescope' },
    { '<leader>sw', function() require('telescope.builtin').grep_string() end, '[S]earch current [W]ord' },
  }
}
