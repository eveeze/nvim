-- Simple debug configuration for fzf-lua files command

-- Create a custom command to test file finding
vim.api.nvim_create_user_command('TestFzfFiles', function()
  local fzf_lua = require('fzf-lua')
  
  -- Test with different commands
  local commands = {
    'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git',
    'rg --files --hidden --follow --glob "!.git/*"',
    'find . -type f -not -path "*/\\.git/*" 2>/dev/null || dir /s /b *.* | findstr /v /i "\\.git"',
    'Get-ChildItem -Recurse -File | Select-Object -ExpandProperty FullName | ForEach-Object { $_ -replace [regex]::Escape((Get-Location).Path + "\\"), "" }',
  }
  
  for i, cmd in ipairs(commands) do
    print(string.format("Testing command %d: %s", i, cmd))
    local ok, result = pcall(function()
      return vim.fn.system(cmd)
    end)
    if ok and result and result ~= '' then
      print(string.format("Command %d works! Output length: %d", i, #result))
      print("First few lines:")
      local lines = vim.split(result, '\n')
      for j = 1, math.min(3, #lines) do
        if lines[j] ~= '' then
          print("  " .. lines[j])
        end
      end
      break
    else
      print(string.format("Command %d failed or empty", i))
    end
  end
end, {})

-- Create a simple files command that definitely works
vim.api.nvim_create_user_command('SimpleFiles', function()
  local fzf_lua = require('fzf-lua')
  
  -- Use PowerShell to get files
  local cmd = 'powershell.exe -Command "Get-ChildItem -Recurse -File | Where-Object { $_.FullName -notlike \'*\\.git\\*\' } | Select-Object -ExpandProperty Name"'
  
  fzf_lua.fzf_exec(cmd, {
    prompt = "Files❯ ",
    actions = {
      ['default'] = function(selected)
        if selected[1] then
          vim.cmd('edit ' .. selected[1])
        end
      end
    }
  })
end, {})

-- Auto setup on Windows
if vim.fn.has('win32') == 1 then
  -- Override the files command after fzf-lua is loaded
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      vim.defer_fn(function()
        local ok, fzf_lua = pcall(require, 'fzf-lua')
        if ok then
          -- Test what works
          print("Testing fzf-lua files commands...")
          
          -- Test fd
          if vim.fn.executable('fd') == 1 then
            print("fd is available")
            local test_fd = vim.fn.system('fd --type f . | head -1')
            if test_fd and test_fd ~= '' then
              print("fd test successful")
            else
              print("fd test failed")
            end
          else
            print("fd is not available")
          end
          
          -- Test rg
          if vim.fn.executable('rg') == 1 then
            print("rg is available")
            local test_rg = vim.fn.system('rg --files . | head -1')
            if test_rg and test_rg ~= '' then
              print("rg test successful")
            else
              print("rg test failed")
            end
          else
            print("rg is not available")
          end
          
          -- Simple override
          fzf_lua.setup({
            files = {
              cmd = 'dir /s /b *.* | findstr /v /i "\\.git"',
              prompt = "Files❯ ",
            }
          })
        end
      end, 1000)
    end,
  })
end
