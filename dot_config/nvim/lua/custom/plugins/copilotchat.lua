return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  config = function()
    vim.keymap.set('n', '<leader>cc', function()
      local input = vim.fn.input 'Quick Chat: '
      if input ~= '' then
        require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
      end
    end)
    vim.keymap.set('n', '<leader>ct', '<cmd>CopilotChatToggle<cr>')
    vim.keymap.set('n', '<leader>cs', '<cmd>CopilotChatSave<cr>')
    vim.keymap.set('n', '<leader>cl', '<cmd>CopilotChatLoad<cr>')
    vim.keymap.set('n', ';c', '<cmd>CopilotChatToggle<cr>')
    require('CopilotChat').setup {}
  end,
}
