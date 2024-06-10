return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    require('smart-splits').setup {
      resize_mode = {
        resize_keys = { 'h', 'j', 'k', 'l' },
      },
    }
  end,
  keys = {
    { ';r', [[<cmd>lua require("smart-splits").start_resize_mode()<cr>]], desc = 'enter resize mode' },
    { '<A-h>', [[<cmd>lua require("smart-splits").move_cursor_left()<cr>]], desc = 'move cursor left' },
    { '<A-j>', [[<cmd>lua require("smart-splits").move_cursor_down()<cr>]], desc = 'move cursor down' },
    { '<A-k>', [[<cmd>lua require("smart-splits").move_cursor_up()<cr>]], desc = 'move cursor up' },
    { '<A-l>', [[<cmd>lua require("smart-splits").move_cursor_right()<cr>]], desc = 'move cursor right' },
  },
}
