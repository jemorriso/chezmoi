-- from https://www.reddit.com/r/vim/comments/139fn2b/plugin_paste_markdown_link_with_title/
function InsertMarkdownURL()
  local url = vim.fn.getreg '+'
  if url == '' then
    return
  end
  local cmd = 'curl -L ' .. vim.fn.shellescape(url) .. ' 2>/dev/null'
  local handle = io.popen(cmd)
  if not handle then
    return
  end
  local html = handle:read '*a'
  handle:close()
  local title = ''
  local pattern = '<title>(.-)</title>'
  local m = string.match(html, pattern)
  if m then
    title = m
  end
  if title ~= '' then
    local markdownLink = '[' .. title .. '](' .. url .. ')'
    vim.api.nvim_put({ markdownLink }, 'c', true, true)
  else
    print 'Title not found for link'
  end
end

Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new {
  cmd = 'lazygit',
  dir = 'git_dir',
  hidden = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
    windblend = 3,
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd 'startinsert!'
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, 't', ';g', '<cmd>close<CR>', { noremap = true, silent = true })
  end,
}

function _Lazygit_toggle()
  lazygit:toggle()
end

-- local function push_changes()
--   if vim.fn.getcwd() == '/Users/jerry/docs/vaults/docs-v6' then
--     local res = vim.fn.system 'git push'
--     if string.find(res, 'fatal:') then
--       vim.notify(res, vim.log.levels.ERROR)
--     -- hyphen is a magic character in lua patterns, escape it with %
--     elseif not string.find(res, 'Everything up%-to%-date') then
--       vim.notify(string.format('Git push: %s', res), vim.log.levels.INFO)
--     end
--   end
-- end

-- call push_changes every 30 seconds
-- local timer = vim.loop.new_timer()
-- timer:start(0, 30000, vim.schedule_wrap(push_changes))
