-- :help options

-- Options Table
local options = {
  -- defaults
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                        -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 50,                         -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 4 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  laststatus = 3,  			               -- when the last window will have a status line
  showcmd = false,				           -- show partial command in the last line of the screen
  ruler = false,                           -- display ruler (status bar) shows linenum,colnum virtualcolnum cursorrelativepos(%)
  numberwidth = 4,                         -- set number column width {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "MonoLisa:h17",                -- the font used in graphical neovim applications default: "monospace:h17"

  -- personal
  guicursor = "",				           -- cursor block all times
  relativenumber = true,                   -- set relative numbered lines
  nu = true,				               -- except cursor line, set line number
  incsearch = true,			               -- move the highlight as you add characters to the search
  cursorcolumn = true,                     -- higlight the current column
  colorcolumn = "80",                      -- set column visual ruler
  -- colorcolumn = "120",
  hidden = true,                           -- opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed
  encoding = "utf-8",
  errorbells = false,
  softtabstop = 4,                         --
  -- set undodir=~/.vim/undodir            -- Install plugin undotree

}

-- Loop
for key, value in pairs(options) do
  vim.opt[key] = value
end

-- special
vim.opt.fillchars.eob=" "
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")              -- hyphenated words by '-' are treated as one word
