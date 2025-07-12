[33mcommit f846cd9595c8e9d273baf87387d89af1f46d1614[m[33m ([m[1;36mHEAD -> [m[1;32mmain[m[33m, [m[1;31morigin/main[m[33m, [m[1;31morigin/HEAD[m[33m)[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 17:22:42 2025 +0700

    COMPLETE REMOVAL of mason-lspconfig.nvim from all language files
    
    Fix all language-specific files that were still using mason-lspconfig.nvim:
    - golang.lua: Convert to direct lspconfig with gopls
    - typescript.lua: Convert to direct lspconfig with vtsls
    - react.lua: Convert to direct lspconfig with vtsls
    - lua.lua: Convert to direct lspconfig with lua_ls
    - svelte.lua: Convert to direct lspconfig with svelte
    
    All files now use:
    - neovim/nvim-lspconfig directly
    - Filetype-specific loading for better performance
    - Comprehensive error handling with pcall
    - Support for both basic and cmp_nvim_lsp capabilities
    - Manual server setup without automatic_enable issues
    
    Also removed mason-lspconfig.nvim from lazy-lock.json
    
    This should completely eliminate the automatic_enable field error
    since no files are using mason-lspconfig.nvim anymore.

[33mcommit ee305eed4ca40c13394f2dfbc3db36ec208174e1[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 17:15:00 2025 +0700

    BYPASS mason-lspconfig to eliminate automatic_enable errors
    
    Problem: mason-lspconfig.nvim has persistent automatic_enable field errors
    Solution: Use direct nvim-lspconfig configuration bypassing mason-lspconfig
    
    Changes:
    - Replace mason-lspconfig.nvim with direct nvim-lspconfig usage
    - Remove problematic automatic_enable feature completely
    - Manual LSP server configuration using lspconfig directly
    - Add basic capabilities for better LSP experience
    - Maintain same functionality without automation errors
    
    Benefits:
    - No more automatic_enable errors on startup
    - Direct control over LSP server configuration
    - Cleaner dependencies (only mason.nvim + nvim-lspconfig)
    - Better reliability and stability
    - Same LSP functionality maintained
    
    Trade-offs:
    - Manual installation required via :Mason
    - No automatic server installation
    - More manual configuration needed
    
    Add comprehensive MASON_LSPCONFIG_BYPASS.md documentation explaining:
    - Problem analysis and root cause
    - Solution implementation details
    - Usage instructions and verification steps
    - Migration notes and troubleshooting guide

[33mcommit 63b10c64a7eb87fb1d78b153c93b4a62e2dc7041[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 17:09:40 2025 +0700

    Simplify mason configuration to avoid enable field errors
    
    Mason.lua changes:
    - Add priority = 1000 to ensure mason loads first
    - Add pcall error handling for mason require
    - Improve error notifications
    
    Mason-lspconfig.nvim changes:
    - Remove automatic_installation feature that causes enable field errors
    - Simplify to basic setup with ensure_installed only
    - Add manual server setup loop instead of setup_handlers
    - Remove complex defer_fn and dependency checking
    - Use event-based loading to avoid startup conflicts
    
    Mason-tool-installer.nvim changes:
    - Add proper dependencies and event handling
    - Add defer_fn with 2 second delay to avoid conflicts
    - Add comprehensive error handling with pcall
    - Use VeryLazy event to load after other mason components
    
    This approach focuses on reliability over advanced features to prevent startup errors.

[33mcommit b59cc0d79932f4ad74eeac8e9988d0efecd6a224[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 17:04:49 2025 +0700

    Fix mason-lspconfig and treesitter-context errors
    
    Mason-lspconfig fixes:
    - Add proper dependencies (mason.nvim, nvim-lspconfig)
    - Change from opts to config function with error handling
    - Add automatic_installation = true
    - Add setup_handlers for automatic server configuration
    - Add pcall error handling for missing modules
    
    Treesitter-context fixes:
    - Simplify autocmd approach to reduce conflicts
    - Add vim.fn.exists() check for TSContext commands
    - Use pcall for all TSContext commands
    - Only handle major problematic filetypes
    - Reduce autocmd complexity to prevent startup errors
    - Maintain global error handler for window ID issues
    
    Both fixes ensure robust error handling and prevent startup crashes.

[33mcommit 2105e043da251010b1a20b4108a9068225794584[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 17:00:30 2025 +0700

    Fix treesitter-context error when using Telescope find_files
    
    - Add proper error handling in test-plugins.lua for treesitter-context
    - Create treesitter-context-fix.lua with comprehensive autocmd handling
    - Add safe buffer option checking to prevent Invalid window id errors
    - Disable treesitter-context for telescope, alpha, dashboard, and other problematic filetypes
    - Add global error handler to silence treesitter-context window errors
    - Integrate autocmd in telescope.lua to disable treesitter-context during telescope operations
    - Add comprehensive TREESITTER_CONTEXT_FIX.md documentation
    - Ensure treesitter-context still works normally for regular file editing
    - Multiple layers of error handling for robust operation

[33mcommit 8ba8e4de932e18616bb963aa37f827ced0b19222[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 16:54:48 2025 +0700

    Switch to Telescope for file finding while keeping fzf-lua for other functions
    
    - Enable Telescope find_files for <leader>ff (reliable on Windows)
    - Add telescope-fzf-native dependency for better performance
    - Disable fzf-lua <leader>ff mapping to avoid conflicts
    - Keep all other fzf-lua functionality intact (live grep, LSP, Git, etc.)
    - Add comprehensive TELESCOPE_SWITCH.md documentation
    - Create hybrid approach: Telescope for files, fzf-lua for everything else
    - Load fzf extension for native fuzzy search performance
    - Maintain all existing keymaps except <leader>ff

[33mcommit 01ab54db6be8c1211daa7691658037dbb669b05a[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 16:41:19 2025 +0700

    Fix fzf-lua files command with proper Windows testing
    
    - Add dynamic command testing for fd, rg, and PowerShell fallback
    - Create get_files_cmd function to test each command before use
    - Add debug print to show which command is being used
    - Simplify configuration with tested working commands
    - Add fzf-simple-fix.lua as alternative approach
    - Update windows-fzf-fix.lua with reliable command detection

[33mcommit 6f942750db09e2577ece694fa625651c7962427d[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 16:40:28 2025 +0700

    Add debug configuration for fzf-lua files command
    
    - Create fzf-debug.lua for testing file finding commands
    - Add TestFzfFiles command to debug different approaches
    - Add SimpleFiles command as fallback
    - Update files command configuration with proper fd/rg setup
    - Add automatic debugging on Windows startup

[33mcommit 065038871e2bc90267bbf1f704438c94d7218063[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 16:34:09 2025 +0700

    Fix fzf-lua Windows compatibility and add troubleshooting guide
    
    - Add Windows-specific PATH management for winget tools
    - Install required dependencies: fzf, ripgrep, bat, fd
    - Create windows-fzf-fix.lua for automatic tool detection
    - Add comprehensive FZF_TROUBLESHOOTING.md guide
    - Update fzf-lua configuration for better Windows support
    - Ensure preview window works with bat integration
    - Fix file search and live grep functionality

[33mcommit d7d6d5b48f6d920184e9d18105d192a4c3820b12[m
Author: eveeze <jsah737@gmail.com>
Date:   Fri Jul 11 16:24:04 2025 +0700

    Add comprehensive configuration and documentation
    
    - Add keymaps documentation (KEYMAPS.md)
    - Add escape keymaps documentation (ESCAPE_KEYMAPS.md)
    - Add features documentation (FEATURES.md)
    - Add Flutter fix documentation (FLUTTER_FIX.md)
    - Add FZF configuration documentation (FZF_CONFIGURED.md)
    - Add Windows-specific fixes (lua/config/windows-fix.lua)
    - Add FZF-lua plugin configuration (lua/plugins/fzf-lua.lua)
    - Add language support plugins (Flutter, React, TypeScript)
    - Add terminal plugin configuration
    - Update general keymaps and plugin configurations
    - Update lazy-lock.json with new plugin dependencies

[33mcommit 01b19d7242c4a2a225983954808bf08bed4e7168[m
Author: rizkia-as-pac <121952580+rizkia-as-pac@users.noreply.github.com>
Date:   Wed Apr 23 18:24:54 2025 +0900

    Update init.lua

[33mcommit 7f813f9f527642ee4d6571fb0a6df2f59e112267[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sun Apr 13 06:30:54 2025 +0900

    refactor(telescope): disable Telescope keymaps and migrate to FzfLua equivalents

[33mcommit a4fe34cf4efe43e92671a698967815cf0d35c70e[m
Merge: ffc346e 2526627
Author: rizkia-as-pac <121952580+rizkia-as-pac@users.noreply.github.com>
Date:   Sat Apr 12 18:11:00 2025 +0900

    Merge pull request #2 from rizkia-as-pac/v2
    
    V2

[33mcommit 2526627c29d3849714e6069c600b93574458463b[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 18:09:37 2025 +0900

    chore(deps): bump plugin versions in lazy-lock.json for latest upstream updates

[33mcommit fd085ae0bfc566fc4eb419b696b6acc1f358665f[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 18:06:48 2025 +0900

    refactor(plugins/lsp): replace mason-null-ls with general tool installer and refactor source setup
    
    - Removed `mason-null-ls.nvim` integration in favor of `mason-tool-installer.nvim`
    - Introduced a deduplication mechanism for tool lists in `setup-sources.lua`
    - Renamed and restructured `setup-sources` to include unified tool list
    - Replaced null-ls source config with direct setup using shared source list

[33mcommit dedc6daddd4b7d441c5fbf070c60b9fc351144aa[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 18:05:30 2025 +0900

    feat(keymaps): add keybindings for plugin package managers and improve config access
    
    - Added keybindings for Lazy, Mason, and Treesitter under <leader>mp namespace
    - Refactored keymap layout for better readability and maintainability
    - Updated which-key groups to include "Package Managers" under <leader>mp

[33mcommit a970b4844c6aaafee35913ca70cf52b6839913f0[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 18:03:48 2025 +0900

    feat(langs): add Lua, Svelte, and TypeScript language support
    
    - Added Lua LSP setup using `lua_ls`
    - Updated Svelte config to include None-LS setup with Prettier formatter
    - Added TypeScript support with Treesitter, vtsls, and Prettier formatting

[33mcommit 09e1fcac75e6a32f8b96e3e87e93a49e71b1c131[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 17:56:12 2025 +0900

    -

[33mcommit ffc346ef73743e6606f8863ff9d600b455f791b7[m
Merge: f937e4a d23cf42
Author: rizkia-as-pac <121952580+rizkia-as-pac@users.noreply.github.com>
Date:   Sat Apr 12 00:31:57 2025 +0900

    Merge pull request #1 from rizkia-as-pac/v2
    
    V2

[33mcommit d23cf42b5ec0ae7c55281c97362bf3e937809a60[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:27:50 2025 +0900

    miscellaneous

[33mcommit 5009e8788dbae9bc3e35949b7bcf132e93af73cd[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:26:54 2025 +0900

    refactor(config): clean up init file and switch to user-config
    
    - Removed old and commented-out configuration setup.
    - Updated `init.lua` to load `user-config` instead of legacy code.
    - Updated `lazy-lock.json` with new plugins and plugin version changes.

[33mcommit 4b611bbddd59feaba7e8af9509be9805c4ca58d2[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:25:17 2025 +0900

    feat(plugins): add auto-save, undotree, treesitter-context, and fzf-lua
    
    Added new plugins for improved UX and productivity:
    - `auto-save.nvim`: enables automatic saving on InsertLeave/TextChanged.
    - `undotree`: allows visualizing undo history via `<leader>z`.
    - `nvim-treesitter-context`: displays the current context at the top.
    - `fzf-lua`: an alternative to Telescope with better UI integration.
    
    Also updated Telescope config:
    - Enhanced keybindings for LSP features and diagnostics.
    - Customized path display and disabled preview for diagnostics.

[33mcommit 9705a40bceabb44b0924df54576bf8ebc2b2618d[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:24:13 2025 +0900

    feat(langs): add language-specific plugin support for Flutter, Go, Svelte, and Zig
    
    - Introduced flutter-tools.nvim plugin with configurations for devtools, widget guides, and LSP features.
    - Added Go (gopls) and Svelte (svelte-language-server) LSP setup with Treesitter and formatter integration.
    - Created modular language plugin system via `langs/init.lua`.
    - Added initial Zig (zls) configuration (currently backup file).

[33mcommit 21d1fb0f3a380d00ce0f2fc600c2c744735cb43c[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:22:34 2025 +0900

    refactor(plugins/core): centralize parser and LSP setup into shared module
    
    - Removed hardcoded Treesitter `ensure_installed` list and replaced it with values from `setup-sources.lua`
    - Centralized Mason LSP and null-ls sources configuration into `setup-sources.lua`
    - Removed unused undotree plugin for cleanup
    - Added backup for previous Treesitter config

[33mcommit 73e8045dd58c86bf264f4e9fb8d98442414a7c91[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:20:56 2025 +0900

    feat(ui): enhance colorscheme options and add scrollEOF plugin
    
    - Added Catppuccin theme with custom palette overrides
    - Updated colorscheme module to include Catppuccin alongside Tokyo Night
    - Introduced scrollEOF.nvim plugin for smooth end-of-file scrolling
    - Extended which-key config with new key labels and grouped mappings
    - DELETE flutter-tools and undotree file

[33mcommit 041f13c750965c90c3aa23729d598b2515c46b97[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:18:47 2025 +0900

    add my notes

[33mcommit 73ce5e6ec13bcd6758524d16b8dcd361ef894346[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:17:55 2025 +0900

    feat(config): add initial user config and plugin extras structure
    
    - Created `user-config/init.lua` and required general keymaps
    - Added `user-config/general-keymaps.lua` with sample keymap
    - Introduced `user-plugins/extras.lua` as a placeholder for custom plugin setups

[33mcommit d8d6d121960599555bbe8b9cbbc17be97cc01057[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Sat Apr 12 00:16:05 2025 +0900

    refactor(config): restructure config files and add custom auto-commands
    
    - Renamed 'keymaps.lua' to 'general-keymaps.lua' for better clarity.
    - Removed unused 'bottom-space.lua' auto command.
    - Added 'auto-commands.lua' for custom behavior such as quickfix closing and yank highlight.
    - Registered config loader for 'auto-commands.lua' in init.
    - Enhanced 'general-keymaps.lua' with better formatting, comment toggle, and config shortcuts.
    - Disabled certain keymaps to improve compatibility with mini.animate plugin.

[33mcommit f937e4a350b781189f485cbb47d613e3a70b047d[m
Author: rizkia-as-pac <121952580+rizkia-as-pac@users.noreply.github.com>
Date:   Tue Jan 28 08:39:14 2025 +0900

    Update cmdline-source.md

[33mcommit d13012eff876a994d04d5606e46f94546f98dc61[m
Author: rizkia-as-pac <121952580+rizkia-as-pac@users.noreply.github.com>
Date:   Tue Jan 28 08:38:41 2025 +0900

    Update cmdline-source.md

[33mcommit e556abce46522f5eb20b3f6fef7a458ac2d32b15[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Tue Jan 28 08:35:53 2025 +0900

    docs: add cmdline source guide and images for cmp integration

[33mcommit 981954890852b92486c67724d2ada1504f57055d[m
Author: Rizkia Adhy Syahputra <rizkia.as.pac@gmail.com>
Date:   Mon Jan 27 00:48:49 2025 +0900

    refactor: improve formatting and structure in config files
