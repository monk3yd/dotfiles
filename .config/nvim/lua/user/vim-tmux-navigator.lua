local status_ok, _ = pcall(require, "vim-tmux-navigator")

if not status_ok then
  vim.notify("Error loading tmux.")
  return
end

-- Write all buffers before navigating from Vim to tmux pane
vim.g.tmux_navigator_save_on_switch = 2
