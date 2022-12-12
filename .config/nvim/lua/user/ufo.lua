local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
  vim.notify("UFO extension error.")
	return
end

-- Need to edit neovim source code and recompile for removing numbers that show
-- fold depth. https://github.com/kevinhwang91/nvim-ufo/issues/4

-- Default fold keybindings:
-- One fold level / All fold levels:
-- "za"/"zA" : toogle fold : remap to leader + z
-- "zc"/"zC": close a fold
-- "zo"/"zO": open a fold

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
keymap('n', 'zR', ufo.openAllFolds)
keymap('n', 'zM', ufo.closeAllFolds)
keymap('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
keymap('n', 'zr', ufo.openFoldsExceptKinds)

-- vim.keymap.set('n', 'K', function()
--     local winid = ufo.peekFoldedLinesUnderCursor()
--     if not winid then
--         vim.lsp.buf.hover()
--     end
-- end)

ufo.setup({
  open_fold_hl_timeout = 150,
  close_fold_kinds = {'imports', 'comment'},
  preview = {
    win_config = {
      border = {'', '─', '', '', '', '─', '', ''},
      winhighlight = 'Normal:Folded',
      winblend = 0
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>'
    }
  },
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end
})
