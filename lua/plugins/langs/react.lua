local setup_sources = require("plugins.core.setup-sources")

return {
  {
    -- Language Parser for React/JSX
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.list_extend(setup_sources.language_parsers, { "javascript", "jsx", "tsx" })
    end,
  },
  {
    -- LSP untuk React
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      vim.list_extend(setup_sources.mason_lsps, { "vtsls" }) -- Already added, but ensures it's available
      
      -- setup client
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      
      -- Configure TypeScript/JavaScript LSP with React support
      lspconfig.vtsls.setup({
        capabilities = capabilities,
        settings = {
          typescript = {
            preferences = {
              includeCompletionsForModuleExports = true,
              includeCompletionsWithSnippetText = true,
            }
          },
          javascript = {
            preferences = {
              includeCompletionsForModuleExports = true,
              includeCompletionsWithSnippetText = true,
            }
          }
        }
      })
    end,
  },
  {
    -- Auto-closing tags for JSX/TSX
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false
        },
        per_filetype = {
          ["html"] = {
            enable_close = false
          }
        }
      })
    end,
  },
  {
    -- Auto pairs for brackets
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
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
  },
  {
    -- React snippets
    "mlaursen/vim-react-snippets",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  }
}
