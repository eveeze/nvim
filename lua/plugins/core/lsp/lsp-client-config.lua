-- lua\plugins\core\lsp\lsp-client-config.lua
-- return {
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       --  format when save
--       vim.api.nvim_create_autocmd('LspAttach', {
--         callback = function(args)
--           local client = vim.lsp.get_client_by_id(args.data.client_id)
--           if not client then return end
--           if client.supports_method('textDocument/formatting') then
--             vim.api.nvim_create_autocmd('BufWritePre', {
--               buffer = args.buf,
--               callback = function()
--                 vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
--               end,
--             })
--           end
--         end,
--       })
--
--       local capabilities = require("cmp_nvim_lsp").default_capabilities()
--       local lspconfig = require("lspconfig")
--
--       lspconfig.lua_ls.setup({ capabilities = capabilities })
--     end,
--   },
-- }
--
-- versi 2
-- return {
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       -- Format when save - PERBAIKAN: Gunakan pendekatan yang lebih aman
--       local format_on_save = function(client, bufnr)
--         if client.supports_method("textDocument/formatting") then
--           vim.api.nvim_create_autocmd("BufWritePre", {
--             buffer = bufnr,
--             callback = function()
--               vim.lsp.buf.format({
--                 bufnr = bufnr,
--                 filter = function(c)
--                   return c.id == client.id -- Hanya format dengan client ini
--                 end
--               })
--             end,
--           })
--         end
--       end
--
--       vim.api.nvim_create_autocmd('LspAttach', {
--         callback = function(args)
--           local client = vim.lsp.get_client_by_id(args.data.client_id)
--           local bufnr = args.buf
--           if not client then return end
--
--           format_on_save(client, bufnr) -- Panggil fungsi format
--         end,
--       })
--
--       local capabilities = require("cmp_nvim_lsp").default_capabilities()
--       local lspconfig = require("lspconfig")
--
--       lspconfig.lua_ls.setup({ capabilities = capabilities })
--     end,
--   },
-- }
--
-- versi 3
-- lua/plugins/core/lsp/lsp-client-config.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim"
  },
  config = function()
    -- Format when save
    local format_on_save = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(c)
                return c.id == client.id
              end
            })
          end,
        })
      end
    end
    
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        if not client then return end
        format_on_save(client, bufnr)
      end,
    })
    
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    
    -- Setup LSP servers that mason-lspconfig will automatically configure
    -- Only setup manually if needed for specific configuration
    lspconfig.lua_ls.setup({ 
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    })
  end,
}
