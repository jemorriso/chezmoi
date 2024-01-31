local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath) -- bootstrap lazy.nvim, LazyVim and your plugins

require("lazy").setup({
  "folke/flash.nvim",
  -- event = "VeryLazy",
  opts = {},
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
  -- {
  --   'nvim-treesitter/nvim-treesitter',
  --   build = ':TSUpdate',
  --   config = function()
  --     require('nvim-treesitter.configs').setup {
  --       -- Add languages to be installed here that you want installed for treesitter
  --       ensure_installed = { 'lua', 'python', 'bash' },
  --
  --       -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  --       auto_install = false,
  --
  --       highlight = { enable = true },
  --       indent = { enable = true },
  --       incremental_selection = {
  --         enable = true,
  --         keymaps = {
  --           init_selection = '<c-space>',
  --           node_incremental = '<c-space>',
  --           scope_incremental = '<c-s>',
  --           node_decremental = '<M-space>',
  --         },
  --       },
  --       textobjects = {
  --         select = {
  --           enable = true,
  --           lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
  --           keymaps = {
  --             -- You can use the capture groups defined in textobjects.scm
  --             ['aa'] = '@parameter.outer',
  --             ['ia'] = '@parameter.inner',
  --             ['af'] = '@function.outer',
  --             ['if'] = '@function.inner',
  --             ['ac'] = '@class.outer',
  --             ['ic'] = '@class.inner',
  --           },
  --         },
  --         move = {
  --           enable = true,
  --           set_jumps = true, -- whether to set jumps in the jumplist
  --           goto_next_start = {
  --             [']m'] = '@function.outer',
  --             [']]'] = '@class.outer',
  --           },
  --           goto_next_end = {
  --             [']M'] = '@function.outer',
  --             [']['] = '@class.outer',
  --           },
  --           goto_previous_start = {
  --             ['[m'] = '@function.outer',
  --             ['[['] = '@class.outer',
  --           },
  --           goto_previous_end = {
  --             ['[M'] = '@function.outer',
  --             ['[]'] = '@class.outer',
  --           },
  --         },
  --         swap = {
  --           enable = true,
  --           swap_next = {
  --             ['<leader>a'] = '@parameter.inner',
  --           },
  --           swap_previous = {
  --             ['<leader>A'] = '@parameter.inner',
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- }
})

vim.g.mapleader = " "
vim.o.clipboard = 'unnamedplus'
-- vim.o.undofile = true

local vscode = require("vscode-neovim")

vim.keymap.set("", "<a-h>", function()
  vscode.action("workbench.action.navigateLeft")
end)
vim.keymap.set("", "<a-j>", function()
  vim.fn.VSCodeNotify("workbench.action.navigateDown")
end)
vim.keymap.set("", "<a-k>", function()
  vim.fn.VSCodeNotify("workbench.action.navigateUp")
end)
vim.keymap.set("", "<a-l>", function()
  vim.fn.VSCodeNotify("workbench.action.navigateRight")
end)

-- copied from lazyvim
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
