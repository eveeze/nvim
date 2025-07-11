-- Fix for treesitter-context window issues

-- Simplified approach: just handle telescope and major problematic filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'TelescopePrompt', 'alpha', 'dashboard', 'NvimTree', 'Trouble', 'lazy' },
  callback = function()
    -- Check if TSContext commands are available
    if vim.fn.exists(':TSContextDisable') == 2 then
      pcall(vim.cmd, 'TSContextDisable')
    end
  end,
})

-- Handle buffer types that are problematic
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local success, buftype = pcall(vim.api.nvim_buf_get_option, 0, 'buftype')
    if success and buftype ~= '' then
      -- Disable for special buffer types
      if vim.tbl_contains({ 'terminal', 'quickfix', 'help', 'nofile' }, buftype) then
        if vim.fn.exists(':TSContextDisable') == 2 then
          pcall(vim.cmd, 'TSContextDisable')
        end
      end
    end
  end,
})

-- Global error handler for treesitter-context
local original_error = vim.api.nvim_err_writeln
vim.api.nvim_err_writeln = function(msg)
  if msg and msg:match('treesitter%-context') and msg:match('Invalid window id') then
    -- Silently ignore treesitter-context window errors
    return
  end
  original_error(msg)
end
