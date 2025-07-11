return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local ok, treesitter_context = pcall(require, 'treesitter-context')
      if not ok then
        vim.notify('treesitter-context not found', vim.log.levels.WARN)
        return
      end
      
      treesitter_context.setup({
        enable = true,
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = function(bufnr)
          -- Safe buffer option check
          local success, ft = pcall(vim.api.nvim_buf_get_option, bufnr, 'filetype')
          if not success then
            return false
          end
          
          -- Disable for certain file types
          local disabled_fts = { 'help', 'alpha', 'dashboard', 'NvimTree', 'Trouble', 'telescope' }
          for _, disabled_ft in ipairs(disabled_fts) do
            if ft == disabled_ft then
              return false
            end
          end
          
          return true
        end,
      })
    end,
  },
  -- Removed fzf-lua configuration because it is now properly configured in a separate file
}
