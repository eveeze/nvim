-- Simple fix for fzf-lua files command on Windows

if vim.fn.has('win32') == 1 then
  -- Wait for fzf-lua to load, then override the files command
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      -- Delay to ensure fzf-lua is fully loaded
      vim.defer_fn(function()
        local ok, fzf_lua = pcall(require, 'fzf-lua')
        if ok then
          -- Override files function with working Windows commands
          local original_files = fzf_lua.files
          
          fzf_lua.files = function(opts)
            opts = opts or {}
            
            -- Try different commands in order of preference
            local commands = {
              -- Try fd first (if available)
              vim.fn.executable('fd') == 1 and 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git' or nil,
              -- Try rg files (if available)
              vim.fn.executable('rg') == 1 and 'rg --files --hidden --follow --glob "!.git/*"' or nil,
              -- Fallback to Windows native command
              'powershell.exe -Command "Get-ChildItem -Recurse -File | Where-Object { $_.FullName -notlike \'*\\.git\\*\' } | Select-Object -ExpandProperty Name"'
            }
            
            -- Find first working command
            for _, cmd in ipairs(commands) do
              if cmd then
                local test_result = vim.fn.system(cmd .. ' 2>NUL | head -1')
                if test_result and test_result ~= '' and not test_result:match('error') then
                  opts.cmd = cmd
                  break
                end
              end
            end
            
            -- If no command worked, use basic dir
            if not opts.cmd then
              opts.cmd = 'dir /s /b *.* 2>NUL | findstr /v /i "\\.git"'
            end
            
            return original_files(opts)
          end
        end
      end, 2000) -- 2 second delay
    end,
  })
end
