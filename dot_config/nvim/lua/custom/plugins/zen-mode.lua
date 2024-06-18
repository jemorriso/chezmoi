return {
  'folke/zen-mode.nvim',
  opts = {},
  config = function()
    vim.keymap.set('n', ';z', '<cmd>ZenMode<cr>')
  end,
}
