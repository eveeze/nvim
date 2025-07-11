return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		ts_update()
	end,
	opts = function()
		local languageParsers = require("plugins.core.setup-sources").language_parsers

		require("nvim-treesitter.configs").setup({
			auto_install = false, -- Disable auto install to avoid path issues
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },

			sync_install = false, -- Use async to avoid blocking
			ensure_installed = {
				"lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
				"javascript", "typescript", "tsx", "json", "html", "css",
				"go", "dart", "yaml"
			}, -- Use specific list instead of variable to avoid issues
		})
	end,
}
