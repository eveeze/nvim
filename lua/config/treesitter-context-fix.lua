-- Fix for treesitter-context window issues

-- Add autocmd to handle treesitter-context errors
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  callback = function()
    -- Check if treesitter-context is available
    local ok, ts_context = pcall(require, 'treesitter-context')
    if not ok then
      return
    end
    
    -- Disable treesitter-context for specific buffer types
    local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    
    -- List of buffer types and file types to disable treesitter-context
    local disabled_buftypes = { 'terminal', 'quickfix', 'help', 'nofile' }
    local disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Trouble', 'telescope', 'lazy' }
    
    for _, bt in ipairs(disabled_buftypes) do
      if buftype == bt then
        vim.cmd('TSContextDisable')
        return
      end
    end
    
    for _, ft in ipairs(disabled_filetypes) do
      if filetype == ft then
        vim.cmd('TSContextDisable')
        return
      end
    end
    
    -- Re-enable for normal buffers
    if buftype == '' and filetype ~= '' then
      vim.cmd('TSContextEnable')
    end
  end,
})

-- Handle telescope specifically
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'TelescopePrompt',
  callback = function()
    vim.cmd('TSContextDisable')
  end,
})

-- Add error handling for treesitter-context
vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function()
    vim.cmd('TSContextDisable')
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
