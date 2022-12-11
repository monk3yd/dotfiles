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

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Move text up and down (normal mode)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Move text up and down (visual mode)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Move text up and down (visual block mode)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Folding remap
keymap("n", "<leader>z", "za", opts)

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Split screen
keymap("n", "<leader>v", ":vsplit<CR>", opts)  -- vertically
keymap("n", "<leader>s", ":split<CR>", opts)  -- horizontally

-- Plugins
-- Toogle HEX Colorizer
keymap("n", "<leader>kt", ":ColorizerToggle<CR>", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope (Fuzzy Finder)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)  -- fzf find files
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)  -- fzf find text
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)  -- fzf find projects
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts) -- fzf find buffers

-- Git (lazygit)
keymap("n", "<leader>gg", "<CMD>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<CMD>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- LSP (Language Server Protocol) (+ handlers.lua)
keymap("n", "<leader>lf", "<CMD>lua vim.lsp.buf.format{ async = true }<CR>", opts)

-- DAP (Debug Adapter Protocol)
keymap("n", "<leader>db", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dc", "<CMD>lua require'dap'.continue()<CR>", opts)
keymap("n", "<leader>di", "<CMD>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<leader>do", "<CMD>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<leader>dO", "<CMD>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>dr", "<CMD>lua require'dap'.repl.toggle()<CR>", opts)
keymap("n", "<leader>dl", "<CMD>lua require'dap'.run_last()<CR>", opts)
keymap("n", "<leader>du", "<CMD>lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<leader>dt", "<CMD>lua require'dap'.terminate()<CR>", opts)
