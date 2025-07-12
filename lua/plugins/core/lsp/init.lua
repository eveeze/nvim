-- lua/plugins/core/lsp/init.lua
return {
  require("plugins.core.lsp.mason"),
  require("plugins.core.lsp.mason-lsp-connector"),
  require("plugins.core.lsp.lsp-client-config"),
  require("plugins.core.lsp.mason-lsp-handlers"), -- File baru
  require("plugins.core.lsp.ls-from-tools"),
  require("plugins.core.lsp.mason-general-installer"),
}
