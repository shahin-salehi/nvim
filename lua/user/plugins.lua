local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- LSP
  "neovim/nvim-lspconfig",
  -- Autocompletion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  -- File explorer
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  -- Status line
  "nvim-lualine/lualine.nvim",

  
  -- Kanagawa
  "rebelot/kanagawa.nvim",

  -- Catppuccin
  "catppuccin/nvim",

  -- Tokyo Night
  "folke/tokyonight.nvim",

  -- Treesitter for syntax
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },


})

-- set color
vim.cmd.colorscheme("tokyonight-night")
