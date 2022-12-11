local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
	return
end

-- Shorten function name
local keymap = vim.keymap.set

vim.g.Illuminate_ftblacklist = {"alpha", "NvimTree"}
keymap("n", "<a-n>", "<CMD>lua require"illuminate".next_reference{wrap=true}<CR>", {noremap=true})
keymap("n", "<a-p>", "<CMD>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>", {noremap=true})

illuminate.configure {
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },
  delay = 200,
  filetypes_denylist = {
    "dirvish",
    "fugitive",
    "alpha",
    "NvimTree",
    "packer",
    "neogitstatus",
    "Trouble",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
    "TelescopePrompt",
  },
  filetypes_allowlist = {},
  modes_denylist = {},
  modes_allowlist = {},
  providers_regex_syntax_denylist = {},
  providers_regex_syntax_allowlist = {},
  under_cursor = true,
}
