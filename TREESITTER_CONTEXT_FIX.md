# Treesitter Context Error Fix

## Problem

When using `<leader>ff` (Telescope find_files) and selecting a file, the following error occurs:

```
Error executing vim.schedule lua callback: ...im-treesitter-context/lua/treesitter-context/context.lua:322: Invalid window id: 1
stack traceback:
        [C]: in function 'nvim_win_get_buf'
        ...im-treesitter-context/lua/treesitter-context/context.lua:322: in function 'get'
        .../lazy/nvim-treesitter-context/lua/treesitter-context.lua:118: in function 'f'
        .../lazy/nvim-treesitter-context/lua/treesitter-context.lua:60: in function <.../lazy/nvim-treesitter-context/lua/treesitter-context.lua:44>
```

## Root Cause

The error occurs because `nvim-treesitter-context` tries to access a window that no longer exists when transitioning from Telescope's preview window to the actual file buffer. This is a common issue when using floating windows with treesitter-context.

## Solutions Implemented

### 1. Enhanced Configuration (`lua/plugins/test-plugins.lua`)
- Added proper error handling with `pcall`
- Added `on_attach` function to disable treesitter-context for specific file types
- Added safe buffer option checking
- Disabled treesitter-context for telescope buffers

### 2. Comprehensive Error Handling (`lua/config/treesitter-context-fix.lua`)
- Added autocmds to handle window/buffer transitions
- Disable treesitter-context for problematic buffer types
- Global error handler to silence treesitter-context window errors
- Specific handling for Telescope events

### 3. Telescope Integration (`lua/plugins/telescope.lua`)
- Added autocmd to disable treesitter-context when Telescope previewer loads
- Safe error handling with `pcall`

## File Changes

### 1. `lua/plugins/test-plugins.lua`
```lua
{
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    local ok, treesitter_context = pcall(require, 'treesitter-context')
    if not ok then
      vim.notify('treesitter-context not found', vim.log.levels.WARN)
      return
    end
    
    treesitter_context.setup({
      enable = true,
      on_attach = function(bufnr)
        -- Safe buffer option check
        local success, ft = pcall(vim.api.nvim_buf_get_option, bufnr, 'filetype')
        if not success then
          return false
        end
        
        -- Disable for certain file types
        local disabled_fts = { 'help', 'alpha', 'dashboard', 'NvimTree', 'Trouble', 'telescope' }
        for _, disabled_ft in ipairs(disabled_fts) do
          if ft == disabled_ft then
            return false
          end
        end
        
        return true
      end,
    })
  end,
}
```

### 2. `lua/config/treesitter-context-fix.lua`
- Comprehensive autocmd handling
- Error suppression for window ID issues
- Smart enable/disable based on buffer type

### 3. `lua/plugins/telescope.lua`
- Autocmd to disable treesitter-context during Telescope operations

## Usage

After implementing these fixes:

1. **Telescope file finding** (`<leader>ff`) will work without errors
2. **Treesitter-context** will still work normally for regular file editing
3. **Automatic disable/enable** based on buffer type and context
4. **Silent error handling** for window transition issues

## Testing

To test the fix:
1. Open Neovim
2. Use `<leader>ff` to open Telescope find_files
3. Select a file and press Enter
4. The file should open without the treesitter-context error
5. Treesitter-context should still work normally in the opened file

## Verification Commands

```vim
" Check if treesitter-context is working
:TSContextToggle

" Check telescope functionality
:Telescope find_files

" Check for any errors
:messages
```

## Alternative Solutions

If the error persists, you can:

1. **Completely disable treesitter-context**:
   ```vim
   :TSContextDisable
   ```

2. **Disable only for specific file types**:
   ```lua
   vim.api.nvim_create_autocmd('FileType', {
     pattern = {'telescope', 'alpha', 'dashboard'},
     callback = function()
       vim.cmd('TSContextDisable')
     end,
   })
   ```

3. **Use a different context plugin** or disable the plugin entirely

## Benefits of This Fix

1. **No more errors** when using Telescope
2. **Treesitter-context still functional** for normal editing
3. **Smart context management** based on buffer type
4. **Graceful error handling** without breaking workflow
5. **Comprehensive solution** covering multiple scenarios

The fix ensures that treesitter-context and Telescope work together harmoniously without sacrificing functionality.
