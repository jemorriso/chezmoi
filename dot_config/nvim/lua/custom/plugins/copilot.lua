return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = false, -- define supertab elsewhere
        accept_word = '<right>',
      },
    },
  },
}
