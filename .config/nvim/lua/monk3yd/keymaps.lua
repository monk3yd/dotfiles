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
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- keymap("n", "<RightMouse>", ":Alpha<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down (Alt)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Copy/Paste
-- vim.api.nvim_set_keymap("n", "<C-c>", '"*y :let @+=@*<CR>', {noremap=true, silent=true})
-- vim.api.nvim_set_keymap("n", "<C-v>", '"+p', {noremap=true, silent=true})

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Split screen
keymap("n", "<leader>v", ":vsplit<CR>", opts)  -- vertically
keymap("n", "<leader>s", ":split<CR>", opts)  -- horizontally

-- Plugins
-- Toogle HEX Colorizer
keymap("n", "<leader>kt", ":ColorizerToggle<CR>", opts)


-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)  -- fzf find files
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)  -- fzf find text
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)  -- fzf find projects
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts) -- fzf find buffers

-- Git
keymap("n", "<leader>gg", "<CMD>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- LSP
keymap("n", "<leader>lf", "<CMD>lua vim.lsp.buf.formatting()<CR>", opts)
keymap("n", "<leader>li", "<CMD>LspInfo<CR>", opts)
keymap("n", "<leader>lI", "<CMD>LspInstallInfo<CR>", opts)
keymap("n", "<leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>ld", "<CMD>Telescope lsp_workspace_diagnostics<CR>", opts)
keymap("n", "<leader>lj", "<CMD>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
keymap("n", "<leader>lk", "<CMD>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts)
keymap("n", "<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
