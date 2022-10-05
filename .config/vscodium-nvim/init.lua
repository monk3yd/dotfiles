-- TODO: One config to rule them all
-- if vim.g.vscode then
    -- VSCode extension
-- else
    -- ordinary Neovim
--end

-- Keymappings --

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Shorten function name
local keymap = vim.keymap.set
-- keymap options
local opts = { silent = true , remap = false }

--   <mode> <keys> <actions> <options>
keymap("n", "Space", "<Nop>", opts)

-- Space as leader key
vim.g.mapleader = " "

-- Better Navigation
keymap("n", "<C-k>" ":call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)
keymap("x", "<C-k>" ":call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)

keymap("n", "<C-j>" ":call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)
keymap("x", "<C-j>" ":call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)

keymap("n", "<C-h>" ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
keymap("x", "<C-h>" ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)

keymap("n", "<C-l>" ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)
keymap("x", "<C-l>" ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)

-- Split editor
keymap("n", "<C-w>s", ":call <SID>split('h')<CR>", opts)
keymap("x", "<C-w>s", ":call <SID>split('h')<CR>", opts)

keymap("n", "<C-w>v", ":call <SID>split('v')<CR>", opts)
keymap("x", "<C-w>v", ":call <SID>split('v')<CR>", opts)

keymap("n", "<C-w>n", ":call <SID>splitNew('h', '__vscode_new__')<CR>", opts)
keymap("x", "<C-w>n", ":call <SID>splitNew('h', '__vscode_new__')<CR>", opts)

-- Manage editor's size
keymap("n", "<C-w>>", ":<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>", opts)
keymap("x", "<C-w>>", ":<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>", opts)

keymap("n", "<C-w>+", ":<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>", opts)
keymap("x", "<C-w>+", ":<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>", opts)

keymap("n", "<C-w><", ":<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>", opts)
keymap("x", "<C-w><", ":<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>", opts)

keymap("n", "<C-w>-", ":<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>", opts)
keymap("x", "<C-w>-", ":<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>", opts)

-- Comments

-- Options -- (maybe replace for vscodium native settings.json ?)
vim.opt.backup = false,                          -- creates a backup file
vim.opt.clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
vim.opt.height = 1,                              -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" }, -- mostly just for cmp
vim.opt.conceallevel = 0,                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8",                  -- the encoding written to a file
vim.opt.hlsearch = true,                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true,                       -- ignore case in search patterns
vim.opt.mouse = "a",                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10,                          -- pop up menu height
vim.opt.showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0,                         -- always show tabs
vim.opt.smartcase = true,                        -- smart case
vim.opt.smartindent = true,                      -- make indenting smarter again
vim.opt.splitbelow = true,                       -- force all horizontal splits to go below current window
vim.opt.splitright = true,                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false,                        -- creates a swapfile
vim.opt.termguicolors = true,                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true,                         -- enable persistent undo
vim.opt.updatetime = 50,                         -- faster completion (4000ms default)
vim.opt.writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true,                        -- convert tabs to spaces
vim.opt.shiftwidth = 4,                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4,                             -- insert 4 spaces for a tab
vim.opt.cursorline = true,                       -- highlight the current line
vim.opt.number = true,                           -- set numbered lines
vim.opt.laststatus = 3,  			             -- when the last window will have a status line
vim.opt.showcmd = false,				         -- show partial command in the last line of the screen
vim.opt.ruler = false,                           -- display ruler (status bar) shows linenum,colnum virtualcolnum cursorrelativepos(%)
vim.opt.numberwidth = 4,                         -- set number column width {default 4}
vim.opt.signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false,                            -- display lines as one long line
vim.opt.scrolloff = 8,                           -- is one of my fav
vim.opt.sidescrolloff = 8,
vim.opt.guifont = "MonoLisa:h17",                -- the font used in graphical neovim applications default: "monospace:h17"

-- personal
vim.opt.guicursor = "",				             -- cursor block all times
vim.opt.relativenumber = true,                   -- set relative numbered lines
vim.opt.nu = true,				                 -- except cursor line, set line number
vim.opt.incsearch = true,			             -- move the highlight as you add characters to the search
vim.opt.cursorcolumn = true,                     -- higlight the current column
vim.opt.colorcolumn = "120",                     -- set column visual ruler
vim.opt.hidden = true,                           -- opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed
vim.opt.encoding = "utf-8",
vim.opt.errorbells = false,
vim.opt.softtabstop = 4,                         --
-- set undodir=~/.vim/undodir            -- Install plugin undotree

-- special
vim.opt.fillchars.eob=" "
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")              -- hyphenated words by '-' are treated as one word
