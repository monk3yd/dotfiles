--- Global Settings ---
require("monk3yd.plugins")

vim.opt.clipboard:append("unnamedplus")  -- set clipboard to global clipboard

--- Context Settings ---
if (vim.g.vscode) then  --- VSCode extension ---
  -- Keymaps --
  -- Shorten function name
  local keymap = vim.keymap.set
  -- Silent keymap option
  local opts = { silent = true }

  --Remap space as leader key
  keymap("", "<Space>", "<Nop>", opts)
  vim.g.mapleader = " "

  -- Modes
  --   normal_mode = "n",
  --   insert_mode = "i",
  --   visual_mode = "v",
  --   visual_block_mode = "x",
  --   term_mode = "t",
  --   command_mode = "c",

  -- Normal --
  -- Better Navigation
  keymap("n", "<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)
  keymap("n", "<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)
  keymap("n", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
  keymap("n", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)

  keymap("x", "<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)
  keymap("x", "<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)
  keymap("x", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
  keymap("x", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)

  -- Comment
  -- keymap("x", "<C-/>", ":call Comment()<CR>", opts)
  -- keymap("n", "<C-/>", ":call Comment()<CR>", opts)

  keymap("x", "<C-/>", ":call Comment()<CR>", opts)
  keymap("n", "<C-/>", ":call Comment()<CR>", opts)

  -- keymap("x", "gc", "<Plug>VSCodeCommentary", {noremap=false})
  -- keymap("n", "gc", "<Plug>VSCodeCommentary", {noremap=false})
  -- keymap("o", "gc", "<Plug>VSCodeCommentary", {noremap=false})
  -- keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {noremap=false})

  -- vim.cmd[[xmap gc <Plug>VSCodeCommentary]]
  -- vim.cmd[[nmap gc <Plug>VSCodeCommentary]]
  -- vim.cmd[[omap gc <Plug>VSCodeCommentary]]
  -- vim.cmd[[nmap gcc <Plug>VSCodeCommentaryLine]]

  -- xmap gc  <Plug>VSCodeCommentary
  -- nmap gc  <Plug>VSCodeCommentary
  -- omap gc  <Plug>VSCodeCommentary
  -- nmap gcc <Plug>VSCodeCommentaryLine

  keymap("n", "<Space>", ":call VSCodeNotify('whichkey.show')<CR>", opts)
  keymap("x", "<Space>", ":call VSCodeNotify('whichkey.show')<CR>", opts)

else  --- Raw Neovim ---
  -- Core Essentials
  require("monk3yd.options")
  require("monk3yd.keymaps")
  require("monk3yd.plugins")
  require("monk3yd.autocommands")
  require("monk3yd.colorscheme")
  require("monk3yd.cmp")
  require("monk3yd.telescope")
  require("monk3yd.treesitter")
  require("monk3yd.autopairs")
  require("monk3yd.comment")
  require("monk3yd.gitsigns")
  require("monk3yd.nvim-tree")
  require("monk3yd.bufferline")
  require("monk3yd.lualine")
  require("monk3yd.toggleterm")
  require("monk3yd.project")
  require("monk3yd.impatient")
  require("monk3yd.illuminate")
  require("monk3yd.indentline")
  require("monk3yd.alpha")

  --  Core Advanced Essentials
  require("monk3yd.lsp")
  require("monk3yd.dap")
  require("monk3yd.tabnine")

  -- Experimental
  require("monk3yd.whichkey")
  require("monk3yd.auto-session")
  require("monk3yd.bookmark")
  require("monk3yd.dressing")
  require("monk3yd.bfs")
end



