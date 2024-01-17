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
    { '<localleader>r', [[<cmd>lua require("smart-splits").start_resize_mode()<cr>]], desc = 'enter resize mode' },
    { '<A-h>', [[<cmd>lua require("smart-splits").move_cursor_left()<cr>]], desc = 'move cursor left' },
    { '<A-j>', [[<cmd>lua require("smart-splits").move_cursor_down()<cr>]], desc = 'move cursor down' },
    { '<A-k>', [[<cmd>lua require("smart-splits").move_cursor_up()<cr>]], desc = 'move cursor up' },
    { '<A-l>', [[<cmd>lua require("smart-splits").move_cursor_right()<cr>]], desc = 'move cursor right' },
    -- { '<C-A-h>', [[<cmd>lua require("smart-splits").resize_left()<cr>]], desc = 'resize left' },
    -- { '<C-A-j>', [[<cmd>lua require("smart-splits").resize_down()<cr>]], desc = 'resize down' },
    -- { '<C-A-k>', [[<cmd>lua require("smart-splits").resize_up()<cr>]], desc = 'resize up' },
    -- { '<C-A-l>', [[<cmd>lua require("smart-splits").resize_right()<cr>]], desc = 'resize right' },
    -- {
    --   '<S-A-h>',
    --   [[<cmd>lua require("smart-splits").swap_buf_left({ move_cursor = true })<cr>]],
    --   desc = 'swap left',
    -- },
    -- {
    --   '<S-A-j>',
    --   [[<cmd>lua require("smart-splits").swap_buf_down({ move_cursor = true })<cr>]],
    --   desc = 'swap down',
    -- },
    -- { '<S-A-k>', [[<cmd>lua require("smart-splits").swap_buf_up({ move_cursor = true })<cr>]], desc = 'swap up' },
    -- {
    --   '<S-A-l>',
    --   [[<cmd>lua require("smart-splits").swap_buf_right({ move_cursor = true })<cr>]],
    --   desc = 'swap right',
    -- },
  },
}
