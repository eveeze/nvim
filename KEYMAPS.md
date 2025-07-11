# Neovim Keymaps Cheat Sheet

## 🎯 Leader Key
- **Leader**: `<space>` (default)

## ⚡ Escape Alternatives
- `jj` - Exit insert mode (alternative to Esc)
- `jk` - Exit insert mode (alternative to Esc)
- `jj` - Exit terminal mode (alternative to Esc)
- `jk` - Exit terminal mode (alternative to Esc)

## 🔍 Fuzzy Finder (fzf-lua)
### File Operations
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files
- `<leader>fs` - Search current word
- `<leader>fu` - Resume last search

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

## 📁 File Explorer
- `<leader>e` - Toggle file explorer
- `<leader>E` - Focus file explorer

## 💻 Terminal
- `<C-\>` - Toggle floating terminal
- `<leader>tf` - Float terminal
- `<leader>tv` - Vertical terminal
- `<leader>ts` - Horizontal terminal (split)
- `<leader>gg` - Lazygit (if available)
- `<leader>tn` - Node.js REPL
- `<leader>tp` - Python REPL
- `<leader>th` - Htop

### Terminal Navigation
- `<Esc>` atau `jk` - Exit terminal mode
- `<C-h>` - Move to left window
- `<C-j>` - Move to window below
- `<C-k>` - Move to window above
- `<C-l>` - Move to right window

## 🚀 Flutter Development
- `<leader>fr` - Flutter Run
- `<leader>fd` - Flutter Devices
- `<leader>fe` - Flutter Emulators
- `<leader>fR` - Flutter Reload (Hot Reload)
- `<leader>fq` - Flutter Quit
- `<leader>fD` - Flutter Detach
- `<leader>fo` - Flutter Outline Toggle
- `<leader>ft` - Flutter DevTools

## 🔧 LSP (Language Server Protocol)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - References
- `gi` - Implementation
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename
- `<leader>f` - Format document
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>q` - Diagnostic list

## 📝 Completion (nvim-cmp)
- `<C-Space>` - Trigger completion
- `<C-n>` - Next completion item
- `<C-p>` - Previous completion item
- `<C-y>` - Confirm completion
- `<C-e>` - Cancel completion
- `<Tab>` - Next snippet placeholder
- `<S-Tab>` - Previous snippet placeholder

## 🎨 Code Editing
- `gcc` - Comment/uncomment current line
- `gc` - Comment/uncomment selection (visual mode)
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>wq` - Save and quit

## 🔄 Window Management
- `<C-w>h` - Move to left window
- `<C-w>j` - Move to window below
- `<C-w>k` - Move to window above
- `<C-w>l` - Move to right window
- `<C-w>v` - Split vertically
- `<C-w>s` - Split horizontally
- `<C-w>c` - Close window
- `<C-w>o` - Close other windows

## 📋 Buffer Management
- `<leader>bd` - Delete buffer
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>ba` - Close all buffers
- `<leader>bo` - Close other buffers

## 🔍 Search & Replace
- `/` - Search forward
- `?` - Search backward
- `n` - Next match
- `N` - Previous match
- `<leader>nh` - No highlight (clear search)
- `:%s/old/new/g` - Replace all occurrences

## 📊 Treesitter
- `<leader>ts` - Toggle treesitter
- `<leader>th` - Toggle highlight
- `<leader>ti` - Toggle indent

## 🎯 Harpoon (Quick File Navigation)
- `<leader>ha` - Add file to harpoon
- `<leader>hh` - Toggle harpoon menu
- `<leader>1` - Navigate to file 1
- `<leader>2` - Navigate to file 2
- `<leader>3` - Navigate to file 3
- `<leader>4` - Navigate to file 4

## 🔧 Trouble (Diagnostics)
- `<leader>xx` - Toggle trouble
- `<leader>xw` - Workspace diagnostics
- `<leader>xd` - Document diagnostics
- `<leader>xl` - Location list
- `<leader>xq` - Quickfix list

## 🎨 Colorscheme
- `<leader>cs` - Select colorscheme
- `<leader>ct` - Toggle colorscheme

## 📱 React/JavaScript Specific
- `<leader>rf` - Format with Prettier
- `<leader>re` - ESLint fix
- `<leader>rc` - React component snippet
- `<leader>rh` - React hook snippet

## 🔄 Undo/Redo
- `u` - Undo
- `<C-r>` - Redo
- `<leader>u` - Undo tree

## 🎯 Quick Actions
- `<leader>x` - Make file executable
- `<leader>so` - Source current file
- `<leader>pv` - Project view
- `<leader>ps` - Project search

## 🔧 Mason (Package Manager)
- `:Mason` - Open Mason UI
- `:MasonInstall <package>` - Install package
- `:MasonUninstall <package>` - Uninstall package
- `:MasonUpdate` - Update all packages

## 📚 Help & Info
- `<leader>?` - Show keymaps
- `:checkhealth` - Check Neovim health
- `:Lazy` - Open Lazy plugin manager
- `:Mason` - Open Mason package manager

## 🎯 Tips
1. Use `<leader>?` untuk melihat semua keymaps yang tersedia
2. Gunakan `<C-\>` untuk quick access ke terminal
3. **Gunakan `jj` atau `jk` sebagai alternatif Esc** - lebih nyaman dari menekan Esc
4. Untuk Flutter development, selalu mulai dengan `<leader>fr`
5. Gunakan `<leader>ff` untuk mencari file dengan cepat
6. `<leader>fg` sangat berguna untuk mencari text dalam project
7. `jj` dan `jk` juga bekerja di terminal mode untuk keluar ke normal mode

## 📝 Custom Snippets
- `rfce` - React Functional Component with Export
- `rafc` - React Arrow Function Component
- `rcc` - React Class Component
- `useState` - React useState hook
- `useEffect` - React useEffect hook
- `clg` - console.log()
- `fun` - JavaScript function
- `afn` - Arrow function
