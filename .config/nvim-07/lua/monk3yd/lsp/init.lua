local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("monk3yd.lsp.lsp-installer")
require("monk3yd.lsp.handlers").setup()
require("monk3yd.lsp.null-ls")
