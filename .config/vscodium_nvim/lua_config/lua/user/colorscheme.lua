-- Sonokai
-- Available values:   `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
vim.g.sonokai_style = "default"
-- Available values:   `'auto'`, `'red'`, `'orange'`, `'yellow'`, `'green'`, `'blue'`, `'purple'`
vim.g.sonokai_cursor = "auto"
vim.g.sonokai_better_performance = 1

-- Available values:   `0`, `1`, `2` (higher means more transparent components)
vim.g.sonokai_transparent_background = 2
vim.g.sonokai_diagnostic_text_highlight = 1

-- Available values:   `'grey background'`, `'bold'`, `'underline'`, `'italic'`
vim.g.sonokai_current_word = "bold"

-- Pallete at sonokai/autoload/sonokai.vim
-- vim.g.sonokai_colors_override = {}
local colorscheme = "sonokai"

-- Gruvbox Material
-- Available values: 'hard', 'medium'(default), 'soft'
-- vim.g.gruvbox_material_background = "medium"
-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_transparent_background = 2
-- vim.g.gruvbox_material_diagnostic_text_highlight = 1
-- vim.g.gruvbox_material_current_word = "bold"
-- local colorscheme = "gruvbox-material"

-- Gruvbox
-- vim.g.gruvbox_contrast_dark = "hard"
-- local colorscheme = "gruvbox"
-- vim.cmd "highlight Normal guibg=none"
-- airline gruvbox theme

-- Load colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
