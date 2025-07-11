# Neovim Configuration Features

Konfigurasi Neovim ini telah diinstal dengan fitur-fitur berikut:

## 🚀 Fitur Utama

### 1. **Auto-closing Tags**
- Plugin: `nvim-ts-autotag`
- Otomatis menutup tag HTML, JSX, TSX
- Otomatis rename tag yang berpasangan

### 2. **Virtual Terminal**
- Plugin: `toggleterm.nvim` dan `nvterm`
- Terintegrasi dengan Neovim
- Keymaps:
  - `<C-\>` - Toggle terminal floating
  - `<leader>tf` - Float terminal
  - `<leader>tv` - Vertical terminal
  - `<leader>ts` - Horizontal terminal
  - `<leader>gg` - Lazygit terminal
  - `<leader>tn` - Node.js REPL
  - `<leader>tp` - Python REPL

### 3. **Auto Pairs**
- Plugin: `nvim-autopairs`
- Otomatis menutup kurung, tanda kutip, dll.

## 🛠️ Dukungan Bahasa Pemrograman

### JavaScript/TypeScript
- **LSP**: `vtsls` (TypeScript Language Server)
- **Parser**: Treesitter untuk JS/TS/JSX/TSX
- **Formatter**: Prettier
- **Linter**: ESLint_d
- **Inlay Hints**: Aktif untuk parameter dan tipe
- **Snippets**: Friendly snippets

### React
- **LSP**: Terintegrasi dengan TypeScript LSP
- **Auto-closing**: Tag JSX/TSX
- **Snippets**: React snippets
- **Formatter**: Prettier dengan React support

### Node.js
- **LSP**: Terintegrasi dengan TypeScript LSP
- **Terminal**: Node.js REPL terintegrasi
- **Debugging**: Siap untuk debugging Node.js

### Go (Golang)
- **LSP**: Sudah dikonfigurasi (dari konfigurasi asli)
- **Parser**: Treesitter untuk Go
- **Formatter**: Terintegrasi

### Flutter/Dart
- **LSP**: Integrated with Flutter-tools (auto-configured)
- **Plugin**: `flutter-tools.nvim`
- **Parser**: Treesitter untuk Dart
- **Auto-closing**: Dart widgets closing tags
- **Keymaps Flutter**:
  - `<leader>fr` - Flutter Run
  - `<leader>fd` - Flutter Devices
  - `<leader>fe` - Flutter Emulators
  - `<leader>fR` - Flutter Reload
  - `<leader>fq` - Flutter Quit
  - `<leader>fD` - Flutter Detach
  - `<leader>fo` - Flutter Outline Toggle
  - `<leader>ft` - Flutter DevTools

## 📋 Tools yang Terinstal

### LSP Servers
- `vtsls` - TypeScript/JavaScript
- Flutter LSP - Integrated with flutter-tools.nvim

### Formatters & Linters
- `prettier` - JavaScript/TypeScript/CSS/HTML/JSON
- Dart built-in formatter via Flutter SDK

### Debug Adapters
- Flutter debugging via flutter-tools.nvim

## 🔧 Konfigurasi Khusus Windows

- **Path Fix**: Menangani path dengan spasi di Windows
- **Shell**: Menggunakan PowerShell untuk compatibility
- **Treesitter**: Dikonfigurasi untuk Windows dengan path yang aman

## 🎯 Keymaps Penting

### Terminal
- `<C-\>` - Toggle terminal
- `<Esc>` atau `jk` - Keluar dari terminal mode
- `<C-h/j/k/l>` - Navigasi antar window dari terminal

### Flutter
- `<leader>fr` - Run Flutter app
- `<leader>fd` - Pilih device
- `<leader>fR` - Hot reload

### Git
- `<leader>gg` - Lazygit (jika tersedia)

## 🔍 Treesitter Parsers

Parser yang terinstal:
- lua, vim, vimdoc, query
- markdown, markdown_inline
- javascript, typescript, tsx, json
- html, css, yaml
- go, dart

## 📦 Plugins Utama

1. **Core**:
   - `nvim-treesitter` - Syntax highlighting
   - `nvim-lspconfig` - LSP configuration
   - `mason.nvim` - Package manager
   - `nvim-cmp` - Autocompletion

2. **Language Support**:
   - `nvim-ts-autotag` - Auto-closing tags
   - `flutter-tools.nvim` - Flutter development
   - `nvim-autopairs` - Auto pairs

3. **Terminal**:
   - `toggleterm.nvim` - Terminal integration
   - `nvterm` - Enhanced terminal

4. **Snippets**:
   - `friendly-snippets` - Snippet collection
   - `vim-react-snippets` - React snippets

## 🚀 Cara Menggunakan

1. **Buka Neovim**: `nvim`
2. **Buka file project**: `nvim your-project`
3. **Terminal**: Tekan `<C-\>` untuk toggle terminal
4. **Flutter**: Buka project Flutter dan gunakan `<leader>fr` untuk run

## 🛠️ Troubleshooting

Jika ada masalah:
1. Jalankan `:checkhealth` di Neovim
2. Pastikan tools terinstal dengan `:Mason`
3. Update parser dengan `:TSUpdate`

## 📚 Dokumentasi Tambahan

- Konfigurasi asli: [Repository asal](https://github.com/eveeze/nvim)
- Lazy.nvim: [Plugin manager documentation](https://github.com/folke/lazy.nvim)
- Mason.nvim: [Package manager documentation](https://github.com/williamboman/mason.nvim)
