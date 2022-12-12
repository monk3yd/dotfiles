local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
    -- inline diagnostics
		virtual_text = false, -- disable virtual text within line (right)
		signs = {
			active = signs, -- show signs within line (left)
		},
		update_in_insert = true,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap

  -- Lsp Status
	keymap(bufnr, "n", "<leader>li", "<CMD>LspInfo<CR>", opts)
	keymap(bufnr, "n", "<leader>lI", "<CMD>LspInstallInfo<CR>", opts)

  -- jump to source
	keymap(bufnr, "n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)

  -- jump to function/class definition
	keymap(bufnr, "n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", opts)

  -- mini documentation popup
	keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)

  -- diagnostics popup
	keymap(bufnr, "n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)

  -- move through diagnostics popups
	keymap(bufnr, "n", "<leader>lj", "<CMD>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
	keymap(bufnr, "n", "<leader>lk", "<CMD>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts)

  -- open buffer with all diagnostics information
	keymap(bufnr, "n", "<leader>lq", "<CMD>lua vim.diagnostic.setloclist()<CR>", opts)

	keymap(bufnr, "n", "gI", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "<leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "n", "<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
	keymap(bufnr, "n", "<leader>ls", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
