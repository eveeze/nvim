return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- File operations
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep_native<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help tags" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { "<leader>fs", "<cmd>FzfLua grep_cword<cr>", desc = "Search current word" },
      
      -- LSP operations
      { "<leader>fd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Go to definition" },
      { "<leader>fD", "<cmd>FzfLua lsp_references<cr>", desc = "Find references" },
      { "<leader>fi", "<cmd>FzfLua lsp_implementations<cr>", desc = "Go to implementation" },
      { "<leader>ft", "<cmd>FzfLua lsp_type_definitions<cr>", desc = "Go to type definition" },
      { "<leader>fS", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>fW", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      
      -- Diagnostics
      { "<leader>fx", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
      { "<leader>fX", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
      
      -- Git operations
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
      { "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
      
      -- Other useful commands
      { "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Colorschemes" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
      { "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix" },
      { "<leader>fl", "<cmd>FzfLua loclist<cr>", desc = "Location list" },
      { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumps" },
      { "<leader>fv", "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>fu", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
    },
    config = function()
      require("fzf-lua").setup({
        -- Global setup
        winopts = {
          height = 0.85,
          width = 0.80,
          row = 0.35,
          col = 0.50,
          border = "rounded",
          preview = {
            scrollbar = "float",
            scrolloff = -2,
            layout = "flex",
            flip_columns = 120,
          },
        },
        keymap = {
          builtin = {
            ["<F1>"] = "toggle-help",
            ["<F2>"] = "toggle-fullscreen",
            ["<F3>"] = "toggle-preview-wrap",
            ["<F4>"] = "toggle-preview",
            ["<F5>"] = "toggle-preview-ccw",
            ["<F6>"] = "toggle-preview-cw",
            ["<S-down>"] = "preview-page-down",
            ["<S-up>"] = "preview-page-up",
            ["<S-left>"] = "preview-page-reset",
          },
          fzf = {
            ["ctrl-z"] = "abort",
            ["ctrl-u"] = "unix-line-discard",
            ["ctrl-f"] = "half-page-down",
            ["ctrl-b"] = "half-page-up",
            ["ctrl-a"] = "beginning-of-line",
            ["ctrl-e"] = "end-of-line",
            ["alt-a"] = "toggle-all",
            ["f3"] = "toggle-preview-wrap",
            ["f4"] = "toggle-preview",
            ["shift-down"] = "preview-page-down",
            ["shift-up"] = "preview-page-up",
          },
        },
        -- Provider setup
        files = {
          prompt = "Files❯ ",
          multiprocess = true,
          git_icons = true,
          file_icons = true,
          color_icons = true,
          cwd_prompt = false,
          cwd_prompt_shorten_len = 32,
          cwd_prompt_shorten_val = 1,
          -- Windows-specific settings - use simple fd command
          cmd = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git",
          -- Alternative commands for fallback
          find_opts = [[-type f -not -path '*/\.git/*']],
          rg_opts = "--files --hidden --follow --glob '!.git/*'",
          fd_opts = "--color=never --type f --hidden --follow --exclude .git --strip-cwd-prefix",
        },
        grep = {
          prompt = "Rg❯ ",
          input_prompt = "Grep For❯ ",
          multiprocess = true,
          git_icons = true,
          file_icons = true,
          color_icons = true,
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
          rg_glob = true,
          glob_flag = "--iglob",
          glob_separator = "%s%-%-",
        },
        -- LSP setup
        lsp = {
          prompt_postfix = "❯ ",
          cwd_only = false,
          async_or_timeout = 5000,
          file_icons = true,
          git_icons = false,
          color_icons = true,
          includeDeclaration = true,
          symbols = {
            async_or_timeout = true,
            symbol_style = 1,
            symbol_icons = {
              File = "󰈙",
              Module = "",
              Namespace = "󰌗",
              Package = "",
              Class = "󰌗",
              Method = "󰆧",
              Property = "",
              Field = "",
              Constructor = "",
              Enum = "󰕘",
              Interface = "󰕘",
              Function = "󰊕",
              Variable = "󰆧",
              Constant = "󰏿",
              String = "󰀬",
              Number = "󰎠",
              Boolean = "◩",
              Array = "󰅪",
              Object = "󰅩",
              Key = "󰌋",
              Null = "󰟢",
              EnumMember = "",
              Struct = "󰌗",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰊄",
            },
          },
        },
        -- Diagnostics setup
        diagnostics = {
          prompt = "Diagnostics❯ ",
          cwd_only = false,
          file_icons = true,
          git_icons = false,
          color_icons = true,
          diag_icons = true,
          icon_padding = "",
          multiline = false,
          signs = {
            ["Error"] = { text = "", texthl = "DiagnosticError" },
            ["Warn"] = { text = "", texthl = "DiagnosticWarn" },
            ["Info"] = { text = "", texthl = "DiagnosticInfo" },
            ["Hint"] = { text = "󰌵", texthl = "DiagnosticHint" },
          },
        },
        -- Git setup
        git = {
          status = {
            prompt = "GitStatus❯ ",
            preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          },
          commits = {
            prompt = "Commits❯ ",
            preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          },
          bcommits = {
            prompt = "BCommits❯ ",
            preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          },
          branches = {
            prompt = "Branches❯ ",
            preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          },
        },
        -- Defaults
        defaults = {
          git_icons = true,
          file_icons = true,
          color_icons = true,
        },
      })
    end,
  },
}
