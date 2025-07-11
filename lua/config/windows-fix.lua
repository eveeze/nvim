-- Fix for Windows path with spaces
local function fix_windows_paths()
  if vim.fn.has('win32') == 1 then
    -- Set proper shell for Windows
    vim.o.shell = "powershell"
    vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
    
    -- Set environment variables to handle paths with spaces
    vim.env.NVIM_APPNAME = "nvim"
    
    -- Handle treesitter installation directory
    local install_dir = vim.fn.stdpath('data') .. '/tree-sitter'
    if not vim.fn.isdirectory(install_dir) then
      vim.fn.mkdir(install_dir, 'p')
    end
  end
end

-- Call the function
fix_windows_paths()
