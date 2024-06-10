return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    direction = 'horizontal',
    size = 20,
    open_mapping = ';j',
    insert_mappings = false,
    -- this shouldn't cause too many problems in terminal mode. ;j is not common.
    terminal_mappings = true,
    shade_terminals = false,
  },
}
