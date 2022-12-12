local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    ["<leader>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local m_opts = {
  mode = "n", -- NORMAL mode
  prefix = "m",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local m_mappings = {
  a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
  c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
  b = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
  m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
  ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
  [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
  l = { "<cmd>lua require('monk3yd.bfs').open()<cr>", "Buffers" },
  j = { "<cmd>silent BookmarkNext<cr>", "Next" },
  s = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
  k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
  S = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
  -- s = {
  --   "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
  --   "Show",
  -- },
  x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
  [";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
}

local mappings = {
  ["a"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Action" },
  -- b = { "<CMD>lua require('monk3yd.bfs').open()<CR>", "Buffers" },
  ["e"] = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
  ["w"] = { "<CMD>w<CR>", "Write" },
  ["h"] = { "<CMD>nohlsearch<CR>", "No HL" },
  ["q"] = { '<CMD>lua require("monk3yd.functions").smart_quit()<CR>', "Quit" },
  ["/"] = { '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
  ["c"] = { "<CMD>Bdelete!<CR>", "Close Buffer" },
  ["P"] = { "<CMD>lua require('telescope').extensions.projects.projects()<CR>", "Projects" },
  -- ["R"] = { '<CMD>lua require("renamer").rename()<CR>', "Rename" },
  -- ["z"] = { "<CMD>ZenMode<CR>", "Zen" },
  ["gy"] = "Link",

  B = {
    name = "Browse",
    i = { "<CMD>BrowseInputSearch<CR>", "Input Search" },
    b = { "<CMD>Browse<CR>", "Browse" },
    d = { "<CMD>BrowseDevdocsSearch<CR>", "Devdocs" },
    f = { "<CMD>BrowseDevdocsFiletypeSearch<CR>", "Devdocs Filetype" },
    m = { "<CMD>BrowseMdnSearch<CR>", "Mdn" },
  },

  p = {
    name = "Packer",
    c = { "<CMD>PackerCompile<CR>", "Compile" },
    i = { "<CMD>PackerInstall<CR>", "Install" },
    s = { "<CMD>PackerSync<CR>", "Sync" },
    S = { "<CMD>PackerStatus<CR>", "Status" },
    u = { "<CMD>PackerUpdate<CR>", "Update" },
  },

  o = {
    name = "Options",
    w = { '<CMD>lua require("monk3yd.functions").toggle_option("wrap")<CR>', "Wrap" },
    r = { '<CMD>lua require("monk3yd.functions").toggle_option("relativenumber")<CR>', "Relative" },
    l = { '<CMD>lua require("monk3yd.functions").toggle_option("cursorline")<CR>', "Cursorline" },
    s = { '<CMD>lua require("monk3yd.functions").toggle_option("spell")<CR>', "Spell" },
    t = { '<CMD>lua require("monk3yd.functions").toggle_tabline()<CR>', "Tabline" },
  },

  -- s = {
  --   name = "Split",
  --   s = { "<CMD>split<CR>", "HSplit" },
  --   v = { "<CMD>vsplit<CR>", "VSplit" },
  -- },

  s = {
    name = "Session",
    s = { "<CMD>SaveSession<CR>", "Save" },
    r = { "<CMD>RestoreSession<CR>", "Restore" },
    x = { "<CMD>DeleteSession<CR>", "Delete" },
    f = { "<CMD>Autosession search<CR>", "Find" },
    d = { "<CMD>Autosession delete<CR>", "Find Delete" },
    -- a = { ":SaveSession<CR>", "test" },
    -- a = { ":RestoreSession<CR>", "test" },
    -- a = { ":RestoreSessionFromFile<CR>", "test" },
    -- a = { ":DeleteSession<CR>", "test" },
  },

  r = {
    name = "Replace",
    r = { "<CMD>lua require('spectre').open()<CR>", "Replace" },
    w = { "<CMD>lua require('spectre').open_visual({select_word=true})<CR>", "Replace Word" },
    f = { "<CMD>lua require('spectre').open_file_search()<CR>", "Replace Buffer" },
  },

  d = {
    name = "Debug",
    b = { "<CMD>lua require'dap'.toggle_breakpoint()<CR>", "Breakpoint" },
    c = { "<CMD>lua require'dap'.continue()<CR>", "Continue" },
    i = { "<CMD>lua require'dap'.step_into()<CR>", "Into" },
    o = { "<CMD>lua require'dap'.step_over()<CR>", "Over" },
    O = { "<CMD>lua require'dap'.step_out()<CR>", "Out" },
    r = { "<CMD>lua require'dap'.repl.toggle()<CR>", "Repl" },
    l = { "<CMD>lua require'dap'.run_last()<CR>", "Last" },
    u = { "<CMD>lua require'dapui'.toggle()<CR>", "UI" },
    x = { "<CMD>lua require'dap'.terminate()<CR>", "Exit" },
  },

  f = {
    name = "Find",
    b = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<CMD>Telescope colorscheme<CR>", "Colorscheme" },
    f = { "<CMD>Telescope find_files theme=ivy<CR>", "Find Files" },
    -- f = {
    --   "<CMD>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = true})<CR>",
    --   "Find files",
    -- },
    t = { "<CMD>Telescope live_grep theme=ivy<CR>", "Find Text" },
    h = { "<CMD>Telescope help_tags<CR>", "Help" },
    i = { "<CMD>lua require('telescope').extensions.media_files.media_files()<CR>", "Media" },
    l = { "<CMD>Telescope resume<CR>", "Last Search" },
    M = { "<CMD>Telescope man_pages<CR>", "Man Pages" },
    r = { "<CMD>Telescope oldfiles<CR>", "Recent File" },
    R = { "<CMD>Telescope registers<CR>", "Registers" },
    k = { "<CMD>Telescope keymaps<CR>", "Keymaps" },
    C = { "<CMD>Telescope commands<CR>", "Commands" },
  },

  g = {
    name = "Git",
    -- D = { "<CMD>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    -- d = { "<CMD>lua vim.lsp.buf.definition()<CR>", "Definition" },
    g = { "<CMD>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<CMD>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
    k = { "<CMD>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
    -- l = { "<CMD>GitBlameToggle<CR>", "Blame" },
    p = { "<CMD>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
    r = { "<CMD>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { "<CMD>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    s = { "<CMD>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    u = { "<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk" },
    o = { "<CMD>Telescope git_status<CR>", "Open changed file" },
    b = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<CMD>Telescope git_commits<CR>", "Checkout commit" },
    },
    G = {
      name = "Gist",
      a = { "<CMD>Gist -b -a<CR>", "Create Anon" },
      d = { "<CMD>Gist -d<CR>", "Delete" },
      f = { "<CMD>Gist -f<CR>", "Fork" },
      g = { "<CMD>Gist -b<CR>", "Create" },
      l = { "<CMD>Gist -l<CR>", "List" },
      p = { "<CMD>Gist -b -p<CR>", "Create Private" },
    },
  -- k = {
  --   name = "Colorizer",
  --   t = { "<CMD>ColorizerToggle<CR>"}
  -- },
  l = {
    name = "LSP",
    a = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<CMD>TroubleToggle<CR>", "Diagnostics" },
    w = {
      "<CMD>Telescope lsp_workspace_diagnostics<CR>",
      "Workspace Diagnostics",
    },
    f = { "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
    F = { "<CMD>LspToggleAutoFormat<CR>", "Toggle Autoformat" },
    i = { "<CMD>LspInfo<CR>", "Info" },
    h = { "<CMD>IlluminationToggle<CR>", "Toggle Doc HL" },
    I = { "<CMD>LspInstallInfo<CR>", "Installer Info" },
    j = {
      "<CMD>lua vim.diagnostic.goto_next({buffer=0})<CR>",
      "Next Diagnostic",
    },
    k = {
      "<CMD>lua vim.diagnostic.goto_prev({buffer=0})<CR>",
      "Prev Diagnostic",
    },
    l = { "<CMD>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    o = { "<CMD>SymbolsOutline<CR>", "Outline" },
    q = { "<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
    r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
    R = { "<CMD>TroubleToggle lsp_references<CR>", "References" },
    s = { "<CMD>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = {
      "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
      "Workspace Symbols",
    },
    t = { '<CMD>lua require("monk3yd.functions").toggle_diagnostics()<CR>', "Toggle Diagnostics" },
    u = { "<CMD>LuaSnipUnlinkCurrent<CR>", "Unlink Snippet" },
  },

  -- s = {
  --   name = "Surround",
  --   ["."] = { "<CMD>lua require('surround').repeat_last()<CR>", "Repeat" },
  --   a = { "<CMD>lua require('surround').surround_add(true)<CR>", "Add" },
  --   d = { "<CMD>lua require('surround').surround_delete()<CR>", "Delete" },
  --   r = { "<CMD>lua require('surround').surround_replace()<CR>", "Replace" },
  --   q = { "<CMD>lua require('surround').toggle_quotes()<CR>", "Quotes" },
  --   b = { "<CMD>lua require('surround').toggle_brackets()<CR>", "Brackets" },
  -- },

  S = {
    -- name = "Session",
    -- s = { "<CMD>SaveSession<CR>", "Save" },
    -- l = { "<CMD>LoadLastSession!<CR>", "Load Last" },
    -- d = { "<CMD>LoadCurrentDirSession!<CR>", "Load Last Dir" },
    -- f = { "<CMD>Telescope sessions save_current=false<CR>", "Find Session" },
    name = "SnipRun",
    c = { "<CMD>SnipClose<CR>", "Close" },
    f = { "<CMD>%SnipRun<CR>", "Run File" },
    i = { "<CMD>SnipInfo<CR>", "Info" },
    m = { "<CMD>SnipReplMemoryClean<CR>", "Mem Clean" },
    r = { "<CMD>SnipReset<CR>", "Reset" },
    t = { "<CMD>SnipRunToggle<CR>", "Toggle" },
    x = { "<CMD>SnipTerminate<CR>", "Terminate" },
  },

  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<CR>", "1" },
    ["2"] = { ":2ToggleTerm<CR>", "2" },
    ["3"] = { ":3ToggleTerm<CR>", "3" },
    ["4"] = { ":4ToggleTerm<CR>", "4" },
    n = { "<CMD>lua _NODE_TOGGLE()<CR>", "Node" },
    u = { "<CMD>lua _NCDU_TOGGLE()<CR>", "NCDU" },
    t = { "<CMD>lua _HTOP_TOGGLE()<CR>", "Htop" },
    p = { "<CMD>lua _PYTHON_TOGGLE()<CR>", "Python" },
    f = { "<CMD>ToggleTerm direction=float<CR>", "Float" },
    h = { "<CMD>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
    v = { "<CMD>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
  },

  T = {
    name = "Treesitter",
    h = { "<CMD>TSHighlightCapturesUnderCursor<CR>", "Highlight" },
    p = { "<CMD>TSPlaygroundToggle<CR>", "Playground" },
    r = { "<CMD>TSToggle rainbow<CR>", "Rainbow" },
  },
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
  s = { "<esc><CMD>'<,'>SnipRun<CR>", "Run range" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(m_mappings, m_opts)
