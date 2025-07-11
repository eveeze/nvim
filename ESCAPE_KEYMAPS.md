# Escape Keymaps Added ⚡

## What's New?

Saya telah menambahkan keymaps alternatif untuk **Escape** yang lebih nyaman:

### 🔑 **Keymaps Baru:**
- **`jj`** - Keluar dari insert mode (sama seperti `<Esc>`)
- **`jk`** - Keluar dari insert mode (sama seperti `<Esc>`)

### 📍 **Dimana Bekerja:**
- ✅ **Insert Mode** - Saat mengetik, gunakan `jj` atau `jk` untuk kembali ke normal mode
- ✅ **Terminal Mode** - Saat di terminal, gunakan `jj` atau `jk` untuk keluar dari terminal mode

### 🎯 **Mengapa Ini Berguna:**
1. **Lebih Ergonomis** - Tidak perlu meraih tombol Esc yang jauh
2. **Faster Workflow** - Jari tetap di home row keyboard
3. **Lebih Natural** - Kombinasi `jj` dan `jk` jarang digunakan dalam pengetikan normal

### 📝 **Cara Menggunakan:**
```
Mode Insert:
- Ketik text normal
- Tekan `jj` atau `jk` untuk kembali ke normal mode
- Langsung bisa menggunakan vim commands

Mode Terminal:
- Buka terminal dengan `<C-\>`
- Ketika ingin keluar dari terminal mode, tekan `jj` atau `jk`
- Akan kembali ke normal mode
```

### 🔧 **File yang Dimodifikasi:**
- `lua/config/general-keymaps.lua` - Keymaps ditambahkan di sini
- `KEYMAPS.md` - Dokumentasi diupdate

### 🚀 **Test Keymaps:**
1. Buka Neovim: `nvim`
2. Tekan `i` untuk masuk insert mode
3. Ketik sesuatu, lalu tekan `jj` atau `jk`
4. Anda akan kembali ke normal mode!

---

**Sekarang coding jadi lebih smooth! 🎉**
