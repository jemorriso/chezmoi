return {
  'catppuccin/nvim',
  lazy = true,
  name = 'catppuccin',
  priority = 1000,
  opts = {
    integrations = {
      fidget = true,
      mason = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
        inlay_hints = {
          background = true,
        },
      },
      neotree = true,
      noice = true,
      notify = true,
      which_key = true,
    },
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin-latte'
  end,
}
