local M = {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = '*',
}

function M.config()
  require("blink.cmp").setup({
    keymap = {
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    sources = {
      default = { 'lsp', 'path', 'buffer' },
      -- Disable cmdline completions
      cmdline = {},
    },
  })
end

return M
