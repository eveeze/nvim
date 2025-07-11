local setup_sources = require("plugins.core.setup-sources")

return {
  {
    -- Language Parser for Dart
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.list_extend(setup_sources.language_parsers, { "dart" })
    end,
  },
  -- Note: Flutter-tools will handle LSP setup automatically
  {
    -- Flutter tools
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "nvim-notify",
        },
        decorations = {
          statusline = {
            app_version = false,
            device = true,
            project_config = false,
          }
        },
        debugger = {
          enabled = false,
          run_via_dap = false,
        },
        flutter_path = nil, -- <-- this takes priority over the lookup
        flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
        fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
        widget_guides = {
          enabled = false,
        },
        closing_tags = {
          highlight = "ErrorMsg",
          prefix = ">",
          enabled = true
        },
        dev_log = {
          enabled = true,
          notify_errors = false,
          open_cmd = "tabedit",
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false
        },
        lsp = {
          color = {
            enabled = false,
            background = false,
            background_color = nil,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          on_attach = function(_, bufnr)
            -- Flutter keymaps
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<leader>fr", ":FlutterRun<CR>", opts)
            vim.keymap.set("n", "<leader>fd", ":FlutterDevices<CR>", opts)
            vim.keymap.set("n", "<leader>fe", ":FlutterEmulators<CR>", opts)
            vim.keymap.set("n", "<leader>fR", ":FlutterReload<CR>", opts)
            vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>", opts)
            vim.keymap.set("n", "<leader>fD", ":FlutterDetach<CR>", opts)
            vim.keymap.set("n", "<leader>fo", ":FlutterOutlineToggle<CR>", opts)
            vim.keymap.set("n", "<leader>ft", ":FlutterDevTools<CR>", opts)
          end,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        }
      })
    end,
  },
  -- Note: Dart has built-in formatter and tools, no need for external ones
}
