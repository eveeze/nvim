local setup_sources = require("plugins.core.setup-sources")

return {
  {
    -- Language Parser
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.list_extend(setup_sources.language_parsers, { "typescript", "javascript", "json", "yaml" })
    end,
  },
  {
    -- LSP
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      vim.list_extend(setup_sources.mason_lsps, { "vtsls" })

      -- setup client
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.vtsls.setup({ 
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })
    end,
  },
  {
    -- Formatter
    "nvimtools/none-ls.nvim",
    opts = function()
      vim.list_extend(setup_sources.mason_general_packages, { "prettier" })
      
      vim.list_extend(setup_sources.null_ls_packages_setup, {
        require("null-ls").builtins.formatting.prettier,
      })
    end
  }
}
