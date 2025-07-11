-- Windows-specific configuration for fzf-lua compatibility

if vim.fn.has('win32') == 1 then
  -- Set environment variables for better tool detection
  local winget_packages = vim.fn.expand('$LOCALAPPDATA/Microsoft/WinGet/Packages')
  
  -- Add winget tools to PATH if they exist
  local tools = {
    'junegunn.fzf_Microsoft.Winget.Source_8wekyb3d8bbwe',
    'BurntSushi.ripgrep.MSVC_Microsoft.Winget.Source_8wekyb3d8bbwe/ripgrep-14.1.1-x86_64-pc-windows-msvc',
    'sharkdp.bat_Microsoft.Winget.Source_8wekyb3d8bbwe/bat-v0.25.0-x86_64-pc-windows-msvc',
    'sharkdp.fd_Microsoft.Winget.Source_8wekyb3d8bbwe/fd-v10.2.0-x86_64-pc-windows-msvc'
  }
  
  local current_path = vim.fn.getenv('PATH')
  for _, tool in ipairs(tools) do
    local tool_path = winget_packages .. '/' .. tool
    if vim.fn.isdirectory(tool_path) == 1 then
      current_path = current_path .. ';' .. tool_path
    end
  end
  vim.fn.setenv('PATH', current_path)
  
  -- Configure fzf-lua for Windows
  vim.g.fzf_preview_window = {'up:50%', 'ctrl-/'}
  
  -- Ensure tools are available
  local function ensure_tool(tool_name, tool_path)
    if vim.fn.executable(tool_name) == 0 then
      local full_path = winget_packages .. '/' .. tool_path
      if vim.fn.isdirectory(full_path) == 1 then
        vim.fn.setenv('PATH', vim.fn.getenv('PATH') .. ';' .. full_path)
      end
    end
  end
  
  -- Ensure all required tools are in PATH
  ensure_tool('fzf', 'junegunn.fzf_Microsoft.Winget.Source_8wekyb3d8bbwe')
  ensure_tool('rg', 'BurntSushi.ripgrep.MSVC_Microsoft.Winget.Source_8wekyb3d8bbwe/ripgrep-14.1.1-x86_64-pc-windows-msvc')
  ensure_tool('bat', 'sharkdp.bat_Microsoft.Winget.Source_8wekyb3d8bbwe/bat-v0.25.0-x86_64-pc-windows-msvc')
  ensure_tool('fd', 'sharkdp.fd_Microsoft.Winget.Source_8wekyb3d8bbwe/fd-v10.2.0-x86_64-pc-windows-msvc')
  
  -- Set Windows-specific fzf-lua options
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      local fzf_lua = require('fzf-lua')
      if fzf_lua then
        fzf_lua.setup({
          files = {
            cmd = 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git',
            previewer = "bat",
          },
          grep = {
            cmd = 'rg --column --line-number --no-heading --color=always --smart-case',
            previewer = "bat",
          },
          preview = {
            cmd = 'bat --style=numbers --color=always --line-range :500 {}',
            border = 'rounded',
            layout = 'flex',
            flip_columns = 120,
            horizontal = 'right:50%',
            vertical = 'down:45%',
          },
        })
      end
    end,
  })
end
