return {
  'epwalsh/obsidian.nvim',
  opts = {
    workspaces = {
      { name = 'docs-v8', path = '~/docs/vaults/docs-v8' },
      { name = 'docs-v7', path = '~/docs/vaults/docs-v7' },
      { name = 'docs-v6', path = '~/docs/vaults/docs-v6' },
      { name = 'docs-v5', path = '~/docs/foam/docs-v5' },
    },
    -- override default note id func so that it just uses the title of the note.
    note_id_func = function(title)
      return title
    end,
    -- only want tags in frontmatter on note creation
    ---@return table
    note_frontmatter_func = function(note)
      local out = { tags = note.tags }
      return out
    end,
  },
  config = function(_, opts)
    vim.keymap.set('n', '<leader>of', '<cmd>ObsidianQuickSwitch<cr>')
    vim.keymap.set('n', '<leader>og', '<cmd>ObsidianSearch<cr>')
    vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>')
    vim.keymap.set('n', '<leader>od', '<cmd>ObsidianToday<cr>')
    vim.keymap.set('n', '<leader>on', ':ObsidianNew ')
    require('obsidian').setup(opts)
  end,
}
