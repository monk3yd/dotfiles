local status_ok, nvim_tmux_nav = pcall(require, "nvim-tmux-navigation")
if not status_ok then
  vim.notify("nvim-tmux-navigation plugin error.")
	return
end

-- nvim_tmux_nav.setup()

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, opts)
keymap('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, opts)
keymap('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, opts)
keymap('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, opts)
keymap('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext, opts)
