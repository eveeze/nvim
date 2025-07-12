return {
  on_attach = function(client, bufnr)
    -- Setup keymaps, diagnostics, dll disini
    local opts = { noremap = true, silent = true, buffer = bufnr }
    
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- Tambahkan mapping lain sesuai kebutuhan
  end,

  capabilities = require('cmp_nvim_lsp').default_capabilities()
}
