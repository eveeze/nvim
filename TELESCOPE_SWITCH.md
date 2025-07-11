# Telescope Switch Documentation

## Overview

Karena ada masalah dengan fzf-lua `<leader>ff` command di Windows, kita sekarang menggunakan Telescope untuk file finding, sementara tetap mempertahankan fzf-lua untuk fungsi lainnya.

## Changes Made

### 1. Telescope Configuration
- **File**: `lua/plugins/telescope.lua`
- **Changes**:
  - Enabled `<leader>ff` for Telescope find_files
  - Added telescope-fzf-native dependency for better performance
  - Configured with fzf extension for native fuzzy finding

### 2. FZF-Lua Configuration
- **File**: `lua/plugins/fzf-lua.lua`
- **Changes**:
  - Disabled `<leader>ff` mapping (commented out)
  - Kept all other fzf-lua functionality intact

## Current Key Mappings

### File Finding (Telescope)
- `<leader>ff` - **Find files (Telescope)** - Now uses Telescope instead of fzf-lua

### Search & Navigation (FZF-Lua - Still Active)
- `<leader>fg` - **Live grep** - Search in file contents
- `<leader>fb` - **Find buffers** - Switch between open buffers
- `<leader>fh` - **Help tags** - Search help documentation
- `<leader>fr` - **Recent files** - Recently opened files
- `<leader>fs` - **Search current word** - Search for word under cursor

### LSP Operations (FZF-Lua - Still Active)
- `<leader>fd` - **Go to definition**
- `<leader>fD` - **Find references**
- `<leader>fi` - **Go to implementation**
- `<leader>ft` - **Go to type definition**
- `<leader>fS` - **Document symbols**
- `<leader>fW` - **Workspace symbols**

### Diagnostics (FZF-Lua - Still Active)
- `<leader>fx` - **Document diagnostics**
- `<leader>fX` - **Workspace diagnostics**

### Git Operations (FZF-Lua - Still Active)
- `<leader>gc` - **Git commits**
- `<leader>gs` - **Git status**
- `<leader>gb` - **Git branches**

### Other Commands (FZF-Lua - Still Active)
- `<leader>fc` - **Colorschemes**
- `<leader>fk` - **Keymaps**
- `<leader>fm` - **Marks**
- `<leader>fq` - **Quickfix**
- `<leader>fl` - **Location list**
- `<leader>fj` - **Jumps**
- `<leader>fv` - **Registers**
- `<leader>fu` - **Resume last search**

## Advantages of This Approach

### Telescope for File Finding
- ✅ **Reliable on Windows** - No path issues
- ✅ **Built-in preview** - Works without external dependencies
- ✅ **Native fuzzy search** - With fzf-native extension
- ✅ **Consistent behavior** - Same across all platforms

### FZF-Lua for Everything Else
- ✅ **Live grep works perfectly** - No issues with rg integration
- ✅ **LSP integration** - Excellent for code navigation
- ✅ **Git integration** - Great for version control operations
- ✅ **Performance** - Fast and responsive

## Usage

### File Finding with Telescope
```vim
<leader>ff
```
- Opens Telescope find_files
- Shows file preview on the right
- Fuzzy search with fzf-native
- Respects .gitignore by default

### Navigation Keys (in Telescope)
- `<C-j>` / `<C-k>` - Move up/down in results
- `<C-p>` / `<C-n>` - Move up/down in results (alternative)
- `<C-u>` / `<C-d>` - Scroll preview up/down
- `<C-q>` - Send to quickfix list
- `<Enter>` - Open selected file
- `<C-x>` - Open in horizontal split
- `<C-v>` - Open in vertical split
- `<C-t>` - Open in new tab
- `<Esc>` - Close telescope

### Live Grep with FZF-Lua
```vim
<leader>fg
```
- Opens fzf-lua live grep
- Real-time search in file contents
- Preview with bat (if available)
- Respects .gitignore

## Dependencies

### Required for Telescope
- `nvim-telescope/telescope.nvim`
- `nvim-lua/plenary.nvim`
- `nvim-telescope/telescope-fzf-native.nvim` (requires make)

### Required for FZF-Lua (already installed)
- `ibhagwan/fzf-lua`
- `nvim-tree/nvim-web-devicons`
- External tools: fzf, rg, bat, fd

## Configuration Files

### Main Configuration Files
- `lua/plugins/telescope.lua` - Telescope configuration
- `lua/plugins/fzf-lua.lua` - FZF-Lua configuration (with ff disabled)

### Windows-specific Files (still present for fzf-lua)
- `lua/config/windows-fzf-fix.lua` - Windows PATH management for fzf-lua
- `lua/config/fzf-debug.lua` - Debug utilities for fzf-lua

## Troubleshooting

### If Telescope doesn't work
1. Check if telescope is installed: `:checkhealth telescope`
2. Verify fzf-native is compiled: `:checkhealth telescope`
3. Try manual command: `:Telescope find_files`

### If FZF-Lua live grep doesn't work
1. Check if rg is installed: `:lua print(vim.fn.executable('rg'))`
2. Check Windows PATH: see `FZF_TROUBLESHOOTING.md`
3. Try manual command: `:FzfLua live_grep`

## Benefits of This Hybrid Approach

1. **Best of both worlds** - Telescope's reliability + FZF-Lua's features
2. **No functional loss** - All original functionality preserved
3. **Windows compatibility** - File finding now works reliably on Windows
4. **Performance** - Each tool used for what it does best
5. **Maintainability** - Clean separation of concerns

This approach ensures that you have reliable file finding on Windows while keeping all the powerful features of fzf-lua for everything else.
