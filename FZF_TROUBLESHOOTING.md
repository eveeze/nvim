# FZF-Lua Troubleshooting Guide

## Windows-Specific Issues and Solutions

### Problem: `<leader>ff` not working or showing error "fzf is not a valid executable"

**Solution:**
1. Install required dependencies:
   ```powershell
   # Install fzf
   winget install fzf
   
   # Install ripgrep for better search
   winget install BurntSushi.ripgrep.MSVC
   
   # Install bat for preview with syntax highlighting
   winget install sharkdp.bat
   
   # Install fd for better file finding
   winget install sharkdp.fd
   ```

2. **Restart your terminal/PowerShell** after installation to reload PATH

3. Verify tools are available:
   ```powershell
   fzf --version
   rg --version
   bat --version
   fd --version
   ```

### Problem: Preview window not working or showing content

**Causes:**
- `bat` not installed or not in PATH
- Preview command not configured properly
- Windows path issues

**Solution:**
1. Ensure `bat` is installed (see above)
2. The configuration now includes Windows-specific fixes in `lua/config/windows-fzf-fix.lua`

### Problem: File search not showing results

**Causes:**
- `fd` or `rg` not available
- Path issues on Windows
- Git repository detection issues

**Solution:**
1. Install `fd` and `rg` (see above)
2. The configuration automatically detects and uses the best available tool
3. Falls back to native commands if external tools aren't available

## Key Bindings

### File Operations
- `<leader>ff` - Find files (uses fd/rg for better performance)
- `<leader>fg` - Live grep (search in file contents)
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files
- `<leader>fs` - Search current word

### LSP Operations
- `<leader>fd` - Go to definition
- `<leader>fD` - Find references
- `<leader>fi` - Go to implementation
- `<leader>ft` - Go to type definition
- `<leader>fS` - Document symbols
- `<leader>fW` - Workspace symbols

### Diagnostics
- `<leader>fx` - Document diagnostics
- `<leader>fX` - Workspace diagnostics

### Git Operations
- `<leader>gc` - Git commits
- `<leader>gs` - Git status
- `<leader>gb` - Git branches

### Other Useful Commands
- `<leader>fc` - Colorschemes
- `<leader>fk` - Keymaps
- `<leader>fm` - Marks
- `<leader>fq` - Quickfix
- `<leader>fl` - Location list
- `<leader>fj` - Jumps
- `<leader>fv` - Registers
- `<leader>fu` - Resume last search

## Preview Window Controls

### While in fzf-lua:
- `F1` - Toggle help
- `F2` - Toggle fullscreen
- `F3` - Toggle preview wrap
- `F4` - Toggle preview on/off
- `F5/F6` - Rotate preview window
- `Shift + Down/Up` - Scroll preview
- `Ctrl + /` - Toggle preview (alternative)

### Navigation:
- `Ctrl + J/K` - Move up/down in results
- `Ctrl + U` - Clear input
- `Ctrl + F/B` - Page down/up
- `Ctrl + A/E` - Beginning/end of line
- `Alt + A` - Toggle all selections
- `Enter` - Open selected file/item
- `Ctrl + Q` - Send to quickfix
- `Ctrl + L` - Send to location list

## Configuration Files

### Main Configuration
- `lua/plugins/fzf-lua.lua` - Main fzf-lua plugin configuration
- `lua/config/windows-fzf-fix.lua` - Windows-specific fixes and PATH management

### Key Features
- Automatic tool detection (fzf, ripgrep, bat, fd)
- Windows PATH management for winget-installed tools
- Preview window with syntax highlighting
- Git integration
- LSP integration
- Diagnostics integration

## Performance Tips

1. **Use ripgrep for search**: Much faster than native grep
2. **Use fd for file finding**: Faster than find and respects .gitignore
3. **Enable preview**: Helps you see content before opening files
4. **Use recent files**: `<leader>fr` for quick access to recently used files

## Common Issues

### Tools not found after installation
- **Solution**: Restart terminal/PowerShell to reload PATH
- **Alternative**: The configuration automatically detects tools in winget packages

### Preview window too small
- **Solution**: Press `F2` for fullscreen or `F4` to toggle preview size
- **Configuration**: Adjust `flip_columns` in configuration (default: 120)

### Slow performance
- **Solution**: Ensure ripgrep and fd are installed and working
- **Check**: Run `:checkhealth` in Neovim to verify plugin status

### Git operations not working
- **Solution**: Ensure you're in a git repository
- **Check**: `git status` should work in the directory

## Troubleshooting Commands

In Neovim:
```vim
:checkhealth fzf-lua
:lua print(vim.fn.executable('fzf'))
:lua print(vim.fn.executable('rg'))
:lua print(vim.fn.executable('bat'))
:lua print(vim.fn.executable('fd'))
```

In terminal:
```powershell
# Check if tools are in PATH
where fzf
where rg
where bat
where fd

# Test tools
fzf --version
rg --version
bat --version
fd --version
```

## Advanced Configuration

The configuration automatically:
- Detects Windows environment
- Adds winget tool paths to PATH
- Configures preview with bat
- Sets up file finding with fd
- Enables Git integration
- Provides comprehensive keymaps

All tools work together to provide a fast, feature-rich fuzzy finding experience in Neovim.
