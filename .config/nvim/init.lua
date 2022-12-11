-- Import configurations by requiring the file path

-- Core
require "user.options"  -- Core options
require "user.plugins"  -- Core plugins
require "user.keymaps"  -- Core keymaps

-- Extensions
require "user.autocommands"
require "user.colorscheme"
require "user.cmp"              -- Completions
require "user.telescope"        -- Fuzzy Finder
require "user.gitsigns"
require "user.treesitter"       -- Syntax Highlight
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"        -- Filesystem
require "user.bufferline"       -- Bufferline (top)
require "user.lualine"          -- Status Line (bottom)
require "user.toggleterm"       -- Terminals
require "user.project"
require "user.impatient"        -- Improve loading speed time
require "user.illuminate"       -- Highlight other uses of word under cursor 
require "user.indentline"       -- Indentation lines
require "user.alpha"            -- Greeter
require "user.lsp"              -- Language Server Protocol
require "user.dap"              -- Debug Adapter Protocol

-- Experiments
require "user.whichkey"              -- Keybindings Display
require "user.nvim-tmux-navigation"  -- Tmux integration
require "user.ufo"                   -- Folding
require "user.dap-python"
