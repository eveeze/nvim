-- lua/plugins/core/lsp/mason-general-installer.lua
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function()
    require('mason-tool-installer').setup {

      -- a list of all tools you want to ensure are installed upon
      -- start
      ensure_installed = require("plugins.core.setup-sources").mason_general_packages,

      -- if set to true this will check each tool for updates. If updates
      -- are available the tool will be updated. This setting does not
      -- affect :MasonToolsUpdate or :MasonToolsInstall.
      -- Default: false
      auto_update = false,

      -- automatically install / update on startup. If set to false nothing
      -- will happen on startup. You can use :MasonToolsInstall or
      -- :MasonToolsUpdate to install tools and check for updates.
      -- Default: true
      run_on_start = true,
    }
  end
}
