-- local setup_sources = require("plugins.core.setup-sources")
--
-- return {
--   {
--     -- LSP
--     "williamboman/mason-lspconfig.nvim",
--     opts = function()
--       vim.list_extend(setup_sources.mason_lsps, { "gopls" })
--
--       -- setup client
--       local capabilities = require("cmp_nvim_lsp").default_capabilities()
--       local lspconfig = require("lspconfig")
--       lspconfig.gopls.setup({ capabilities = capabilities })
--     end,
--   },
-- }

local setup_sources = require("plugins.core.setup-sources")

return {
  {
    -- Language Parser for Go
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.list_extend(setup_sources.language_parsers, { "go", "gomod", "gowork", "gosum" })
    end,
  },
  {
    -- LSP Configuration
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      vim.list_extend(setup_sources.mason_lsps, { "gopls" })

      -- Enhanced gopls setup
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
              nilness = true,
              unusedwrite = true,
              useany = true,
            },
            staticcheck = true,
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
        on_attach = function(client, bufnr)
          -- Go specific keymaps (avoid conflict with toggleterm)
          local opts = { noremap = true, silent = true, buffer = bufnr }

          -- Build and run
          vim.keymap.set("n", "<leader>gb", ":!go build<CR>", opts)
          vim.keymap.set("n", "<leader>gr", ":!go run %<CR>", opts)
          vim.keymap.set("n", "<leader>gt", ":!go test<CR>", opts)
          vim.keymap.set("n", "<leader>gT", ":!go test -v<CR>", opts)
          vim.keymap.set("n", "<leader>gc", ":!go test -cover<CR>", opts)

          -- Go tools
          vim.keymap.set("n", "<leader>gf", ":!go fmt %<CR>", opts)
          vim.keymap.set("n", "<leader>gi", ":!goimports -w %<CR>", opts)
          vim.keymap.set("n", "<leader>gm", ":!go mod tidy<CR>", opts)
          vim.keymap.set("n", "<leader>gv", ":!go vet<CR>", opts)

          -- LSP specific
          vim.keymap.set("n", "<leader>gI", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>gR", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>gD", vim.lsp.buf.type_definition, opts)
        end,
      })
    end,
  },
  {
    -- Formatter and tools - PERBAIKAN DISINI
    "nvimtools/none-ls.nvim",
    opts = function()
      -- Install Go tools via Mason
      vim.list_extend(setup_sources.mason_general_packages, {
        "gofumpt",       -- Enhanced gofmt
        "goimports",     -- Import management
        "golangci-lint", -- Comprehensive linter
        "staticcheck",   -- Static analysis
        "gotests",       -- Generate tests
        "impl",          -- Generate interface implementations
      })

      -- Cek apakah none-ls sudah ter-load
      local status_ok, null_ls = pcall(require, "null-ls")
      if not status_ok then
        vim.notify("none-ls not found", vim.log.levels.ERROR)
        return
      end

      -- Safely extend null_ls packages
      if setup_sources.null_ls_packages_setup then
        vim.list_extend(setup_sources.null_ls_packages_setup, {
          -- Formatting
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports,
          -- Linting
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.staticcheck,
          -- Code actions
          null_ls.builtins.code_actions.impl,
        })
      end
    end,
  },
  {
    -- Go debugging support
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    ft = "go",
    config = function()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug Package",
            request = "launch",
            program = "${fileDirname}",
          },
          {
            type = "go",
            name = "Debug Test",
            request = "launch",
            mode = "test",
            program = "${file}",
          },
        },
      })

      -- Debug keymaps
      vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {})
      vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {})
      vim.keymap.set("n", "<leader>ds", ":DapStepOver<CR>", {})
      vim.keymap.set("n", "<leader>di", ":DapStepInto<CR>", {})
      vim.keymap.set("n", "<leader>do", ":DapStepOut<CR>", {})
      vim.keymap.set("n", "<leader>dt", ":DapTerminate<CR>", {})
    end,
  },
  {
    -- Go testing
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
    },
    ft = "go",
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          }),
        },
      })
    end,
  },
  {
    -- Go snippets
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Custom Go snippets
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("go", {
        s("iferr", {
          t("if err != nil {"),
          t({ "", "\t" }),
          i(1, "return err"),
          t({ "", "}" }),
        }),
        s("fmtp", {
          t('fmt.Printf("'),
          i(1, "%v"),
          t('\\n", '),
          i(2, "variable"),
          t(")"),
        }),
      })
    end,
  },
  {
    -- Enhanced Go support
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        goimport = "gopls",
        gofmt = "gofumpt",
        -- max_line_len = 120, -- Removed: gofumpt handles line length automatically
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "  ",
        lsp_cfg = false, -- gopls already configured above
        lsp_gofumpt = true,
        lsp_on_attach = false,
        dap_debug = true,
        dap_debug_keymap = false, -- set to false to disable default keymaps
        textobjects = true,
        test_runner = "go",
        verbose_tests = true,
        run_in_floaterm = false,
        trouble = false, -- Nonaktifkan integrasi dengan 'trouble.nvim' jika tidak digunakan
        test_efm = true,
        luasnip = true,
      })

      -- Additional Go keymaps
      vim.keymap.set("n", "<leader>gj", ":GoAddTag<CR>", {})
      vim.keymap.set("n", "<leader>gk", ":GoRmTag<CR>", {})
      vim.keymap.set("n", "<leader>gF", ":GoFillStruct<CR>", {})
      vim.keymap.set("n", "<leader>gE", ":GoIfErr<CR>", {})
      vim.keymap.set("n", "<leader>gA", ":GoAlt<CR>", {})
    end,
  },
}
