return {
  'epwalsh/obsidian.nvim',
  opts = {
    workspaces = {
      { name = 'docs-v7', path = '~/docs/vaults/docs-v7' },
      { name = 'docs-v6', path = '~/docs/vaults/docs-v6' },
      { name = 'docs-v5', path = '~/docs/foam/docs-v5' },
    },
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
