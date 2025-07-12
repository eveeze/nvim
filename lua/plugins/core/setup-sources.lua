-- lua/plugins/core/setup-sources.lua
local M = {}

-- for treesitter parser
M.language_parsers = {
  -- list lang parsers : https://github.com/nvim-treesitter/nvim-treesitter/tree/master?tab=readme-ov-file#supported-languages
  -- "svelte"
}

-- for lsp installed from mason
M.mason_lsps = {
  -- source :  https://mason-registry.dev/registry/list
  -- atau lihat saja dari :Mason, contoh => (v) rust-analyzer rust_analyzer, rust_analyzer (keywords: rust) -- yang ditulis adalah rust_analyzer (yg ditulis adalah nama packagenya, atau jika ada nama setelah package tersebut, atau apapun sebelum tanda kurung dari keyword)
  "lua_ls",
  "rust_analyzer",
  -- TODO: Typescript ls, vtls
}

-- for all mason packages type
M.mason_general_packages = {
  -- you can pin a tool to a particular version
  -- { 'golangci-lint',        version = 'v1.47.0' },
  -- you can turn off/on auto_update per tool
  -- { 'bash-language-server', auto_update = true },
  -- you can do conditional installing
  -- {'gopls',                condition = function() return not os.execute("go version") end },
  -- 'lua-language-server',
  -- 'vim-language-server',
  -- 'stylua',
  -- 'shellcheck',
  -- 'editorconfig-checker',
  -- 'gofumpt',
  -- 'golines',
  -- 'gomodifytags',
  -- 'gotests',
  -- 'impl',
  -- 'json-to-struct',
  -- 'luacheck',
  -- 'misspell',
  -- 'revive',
  -- 'shellcheck',
  -- 'shfmt',
  -- 'staticcheck',
  -- 'vint',
}


M.null_ls_packages_setup = {
  -- sumber : https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#diagnostics
}

function M.dedupe_list(list)
  local seen, unique = {}, {}
  for _, item in ipairs(list) do
    if not seen[item] then
      seen[item] = true
      table.insert(unique, item)
    end
  end
  return unique
end

return M
