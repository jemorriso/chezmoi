return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>')
    vim.keymap.set('n', '<leader>gg', '<cmd>Git commit -am "update"<cr>')
    vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>')
    vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<cr>')
    vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>')
  end,
}
