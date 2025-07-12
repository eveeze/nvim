-- Fix for Windows path with spaces
-- local function fix_windows_paths()
--   if vim.fn.has('win32') == 1 then
--     -- Set proper shell for Windows
--     vim.o.shell = "powershell"
--     vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
--     vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
--     vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
--     vim.o.shellquote = ""
--     vim.o.shellxquote = ""
--
--     -- Set environment variables to handle paths with spaces
--     vim.env.NVIM_APPNAME = "nvim"
--
--     -- Handle treesitter installation directory
--     local install_dir = vim.fn.stdpath('data') .. '/tree-sitter'
--     if not vim.fn.isdirectory(install_dir) then
--       vim.fn.mkdir(install_dir, 'p')
--     end
--   end
-- end
--
-- -- Call the function
-- fix_windows_paths()

-- lua/config/windows-fix.lua

-- Fix untuk Windows agar lebih kompatibel dengan plugin Vim/Neovim
local function fix_windows_environment()
  if vim.fn.has('win32') ~= 1 then
    return
  end

  -- Mengatur PowerShell sebagai shell utama, tetapi dengan flag yang lebih sederhana
  vim.o.shell = "powershell.exe"
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy Bypass -Command"

  -- Menggunakan pengaturan shellredir dan shellpipe yang lebih standar dan tidak mengubah encoding
  -- Ini adalah kunci perbaikan untuk netrw
  vim.o.shellredir = '>%s 2>&1'
  vim.o.shellpipe = '>%s 2>&1'

  -- Biarkan Neovim menangani quoting secara default
  vim.o.shellquote = ''
  vim.o.shellxquote = ''

  -- Menangani direktori instalasi treesitter untuk path dengan spasi
  local install_dir = vim.fn.stdpath('data') .. '/tree-sitter'
  if not vim.fn.isdirectory(install_dir) then
    vim.fn.mkdir(install_dir, 'p')
  end
end

-- Panggil fungsi perbaikan
fix_windows_environment()
