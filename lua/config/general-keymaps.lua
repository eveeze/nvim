-- setup `mapleader` and `maplocalleader` before lazyvim
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ===================================================================
-- ESCAPE ALTERNATIVES - jj and jk to exit insert mode
-- ===================================================================
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- For terminal mode as well
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { desc = "Exit terminal mode with jj" })
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode with jk" })


vim.keymap.set("n", "<leader>s", function() vim.cmd('w') end) -- just for some convenion

vim.keymap.set("n", "<leader>t", vim.cmd.Ex)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- vim.keymap.set("n", "<C-u>", "<C-u>zz") -- disable to prevent weird motion when use mini.animate plugin
-- vim.keymap.set("n", "<C-d>", "<C-d>zz") -- disable to prevent weird motion when use mini.animate plugin

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>cs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { silent = true })

--vim.keymap.set({ "n", "v" }, "<leader>c/", function()
vim.keymap.set({ "n", "v" }, "<C-_>", function() -- <C-_> = ctrl + /
  vim.cmd("normal gcc")
end, { desc = "Comment" })

-- WINDOW
vim.keymap.set("n", "<leader>uv", function()
  vim.cmd("vsplit")
end, { desc = "Split window left" })

vim.keymap.set("n", "<leader>uh", function()
  vim.cmd("split")
end, { desc = "Split window bellow" })

vim.keymap.set("n", "<leader>ud", function()
  vim.cmd("close")
end, { desc = "Delete window" })

vim.keymap.set("n", "<leader>w", "<c-w>", { desc = "Move to next window" })

-- vim.keymap.set("n", "<leader>u+", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- vim.keymap.set("n", "<leader>u-", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<leader>uj", "<cmd>vertical resize -50<cr>", { desc = "Decrease window width by 50col" })
vim.keymap.set("n", "<leader>uk", "<cmd>vertical resize +50<cr>", { desc = "Increase window width by 50col" })
vim.keymap.set("n", "<leader>un", "<cmd>wincmd =<cr>", { desc = "Reset window width to normal" })

-- vim.keymap.set(
--   "n",
--   "<leader>sx",
--   require("telescope.builtin").resume,
--   { noremap = true, silent = true, desc = "resume" }
-- )

--
-- QUICK FIX LOCAL AND GLOBAL
-- vim.keymap.set("n", "<leader>xx", "<cmd>lopen<cr>", { desc = "Location List (local to current window)" }) -- use telescope instead
-- vim.keymap.set("n", "<leader>xg", "<cmd>copen<cr>", { desc = "Quickfix List (global)" }) -- use telescope instead

-- "neovim/nvim-lspconfig",
vim.keymap.set("n", "<leader>mlc", function()
  vim.cmd("checkhealth vim.lsp")
end, { desc = "Check LSP health" })

vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Code action" })


-- █▀█ ▄▀█ █▀▀ █▀▄▀█ ▄▀█ █▄░█ █▀
-- █▀▀ █▀█ █▄▄ █░▀░█ █▀█ █░▀█ ▄█
-- folke / lazy.nvim
vim.keymap.set("n", "<leader>mpl", function()
  vim.cmd("Lazy")
end, { desc = "Open Lazy" })

-- williamboman / mason.nvim
vim.keymap.set("n", "<leader>mpm", function()
  vim.cmd("Mason")
end, { desc = "Open Mason" })

-- nvim-treesitter / nvim-treesitter
vim.keymap.set("n", "<leader>mpt", "<cmd>TSInstallInfo<CR>", { desc = "Open Treesitter PM" })
-- ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄


-- "nvimtools/none-ls",
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "vim.lsp.buf.format/none-ls format" })
-- vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "go to definition" }) -- use telescope definition instead


vim.keymap.set({ "n" }, "<leader>cpp", function() -- <C-_> = ctrl + /
  vim.cmd("normal gqip")
end, { desc = "format paragraph" })

vim.keymap.set({ "n" }, "<leader>cpl", function() -- <C-_> = ctrl + /
  vim.cmd("normal gq$")
end, { desc = "format line" })


-- QUICK ACCESS TO CONFIG
vim.keymap.set("n", "<leader>mca", "<cmd>exe 'edit' stdpath('config').'/lua/config/auto-commands.lua'<cr>",
  { desc = "auto-commands" })
vim.keymap.set("n", "<leader>mck", "<cmd>exe 'edit' stdpath('config').'/lua/config/general-keymaps.lua'<cr>",
  { desc = "general-keymaps" })
vim.keymap.set("n", "<leader>mco", "<cmd>exe 'edit' stdpath('config').'/lua/config/options.lua'<cr>",
  { desc = "options" })
vim.keymap.set("n", "<leader>mce", "<cmd>exe 'edit' stdpath('config').'/lua/plugins/extras.lua'<cr>",
  { desc = "plugin/extras" })
vim.keymap.set("n", "<leader>mct", "<cmd>exe 'edit' stdpath('config').'/lua/plugins/test-plugins.lua'<cr>",
  { desc = "plugin/test-plugins" })
vim.keymap.set("n", "<leader>mcn", "<cmd>exe 'edit' stdpath('config').'/my-nvim-notes.md'<cr>",
  { desc = "my nvim notes" })
vim.keymap.set("n", "<leader>mcs", "<cmd>so %<cr>", { desc = "source this buffer" })
vim.keymap.set("n", "<leader>mh", "<cmd>exe 'edit' stdpath('config').'/my-nvim-notes.md'<cr>", { desc = "my cheatsheet" })


vim.keymap.set("n", "<leader>fb", "<cmd>b#<cr>", { desc = "Back to previous buffer" })

-- SAVE FOR LATER

-- Move Lines
-- map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
-- map("n", "<a-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "move up" })
-- map("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "move down" })
-- map("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "move up" })
-- map("v", "<a-j>", ":<c-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "move down" })
-- map("v", "<a-k>", ":<c-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "move up" })


-- map("v", "<a-k>", ":<c-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "move up" })
-- map("v", "<a-k>", ":<c-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "move up" })
-- map("v", "<a-k>", ":<c-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "move up" })
-- map("v", "<a-k>", ":<c-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "move up" })
-- map("v", "<a-k>", ":<c-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "move up" })
