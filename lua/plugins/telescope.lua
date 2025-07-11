return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { 
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	keys = {
		-- Enable find_files for leader ff (override fzf-lua)
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			desc = "Find files (Telescope)",
		},
		-- Keep other telescope commands commented for now
		-- { "<leader>fg", "<cmd>Telescope git_files<cr>" },
		-- { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
		-- { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope all references" },
		-- {
		-- 	"<leader>fs",
		-- 	"<cmd>Telescope lsp_document_symbols<cr>",
		-- 	desc = "Lists LSP document symbols in the current buffer",
		-- },
		-- {
		-- 	"<leader>fd",
		-- 	"<cmd>Telescope lsp_definitions<cr>",
		-- 	desc = "Goto the definition of the word under the cursor",
		-- },
		-- {
		-- 	"<leader>fx",
		-- 	"<cmd>Telescope diagnostics<cr>",
		-- 	desc = "Lists Diagnostics for all open buffers or a specific buffer",
		-- },
		--
		-- { "<leader>muC", "<cmd>Telescope colorscheme<cr>", desc = "Lists Colorscheme" },
	},
	opts = function()
		require("telescope").setup({
			builtin = {
				diagnostics = {
					previewer = false,
				},
			},
			defaults = {
				path_display = { truncate = 2 },
				-- path_display =  "truncate"
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
			extensions = {
				fzf = {}, -- use native fzf to make it better and faster
			},
		})

		-- Load fzf extension
		require('telescope').load_extension('fzf')

		vim.keymap.set("n", "<leader>mlp", function()
			require("telescope.builtin").find_files({
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
			})
		end)
	end,
}
