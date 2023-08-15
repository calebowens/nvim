-- Bootstrap lazy.nvim, plugin manager
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
vim.opt.rtp:prepend(lazypath)

-- Set vim leader key to space
-- Still not convinced about this one
vim.g.mapleader = " "

-- Set plugins for lazy to install
require("lazy").setup({
  -- "robertmeta/nofrils",
  "morhetz/gruvbox",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  "tpope/vim-sleuth",
  -- "tpope/vim-vinegar",
  -- "m4xshen/hardtime.nvim"
})

-- Set colorscheme
vim.cmd.colorscheme("gruvbox")

-- Nvim Telescope
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- DOWN WITH THE MOUSE
vim.opt.mouse = nil

-- Make haml files easier to read
vim.opt.cursorcolumn = true
vim.opt.cursorline = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Keep cursor from bashing into the side of the window
vim.opt.scrolloff = 5

-- Never have it easy!
local hardtime_config = {
   max_time = 1000,
   max_count = 2,
   disable_mouse = true,
   hint = true,
   allow_different_key = false,
   resetting_keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9",
      "c", "C", "d", "x", "X", "y", "Y", "p", "P" },
   restricted_keys = { "h", "j", "k", "l", "+", "gj", "gk" },
   hint_keys = { "k", "j", "^", "$", "a", "i", "d", "y", "c", "l" },
   disabled_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" },
   disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason" }
}
-- require("hardtime").setup(hardtime_config)

-- Vinegar but less
vim.keymap.set('n', '-', '<cmd>Ex<cr>', {})
vim.g.netrw_banner = 0
