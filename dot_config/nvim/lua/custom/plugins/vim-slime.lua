return {
  'jpalardy/vim-slime',
  config = function()
    vim.g.slime_target = 'tmux'

    local slime_dict = {}
    slime_dict.socket_name = 'default'
    slime_dict.target_pane = ':.1'
    vim.g.slime_default_config = slime_dict
  end,
}
