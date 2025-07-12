-- lua/plugins/core/lsp/mason-lsp-handlers.lua
-- File baru untuk menangani automatic setup dari mason-lspconfig
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Pastikan mason-lspconfig sudah disetup terlebih dahulu
    if not mason_lspconfig.setup_handlers then
      return
    end

    -- Setup handlers untuk automatic LSP configuration
    mason_lspconfig.setup_handlers({
      -- Default handler untuk semua LSP servers
      function(server_name)
        -- Skip servers yang sudah dikonfigurasi manual
        if server_name == "lua_ls" then
          return
        end

        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
    })
  end,
}
