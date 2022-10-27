local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local servers = {
    "sumneko_lua",
    "cssls",
    "html",
    "tsserver",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
}

lsp_installer.setup({
    automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see examples below).
for _, server in pairs(servers) do
    opts = {
        on_attach = require("monk3yd.lsp.handlers").on_attach,
        capabilities = require("monk3yd.lsp.handlers").capabilities,
    }

    if server == "sumneko_lua" then
        local sumneko_opts = require("monk3yd.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require "monk3yd.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "jsonls" then
        local jsonls_opts = require("monk3yd.lsp.settings.jsonls")
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    -- Refer to https://github.com/nvim-lspconfig/blob/master/doc/server_configurations.md
    lspconfig[server].setup(opts)
end
