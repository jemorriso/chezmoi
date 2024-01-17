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
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
})

vim.g.mapleader = " "

local vscode = require("vscode-neovim")
vim.keymap.set({ "n" }, "<leader>pz", function()
	vscode.action("workbench.action.quickOpen")
end)
-- vim.keymap.set({ "n" }, "<leader>pt", function()
-- 	vim.fn.VSCodeNotify("workbench.action.quickOpen")
-- end)

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

