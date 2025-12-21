-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  local opts = { silent = true, buffer = bufnr }
  local min_severity = { min = vim.diagnostic.severity.WARN }

  vim.keymap.set("n", "<LocalLeader>x", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<LocalLeader>dr", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<LocalLeader>do", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<LocalLeader>k", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

  -- diagnostics, only warn/error
  vim.keymap.set("n", "<LocalLeader>dn", function()
    vim.diagnostic.jump({ count = 1, severity = min_severity, float = false })
  end, opts)
  vim.keymap.set("n", "<LocalLeader>dp", function()
    vim.diagnostic.jump({ count = -1, severity = min_severity, float = false })
  end, opts)

  -- enable diagnosts for warn/error only
  vim.diagnostic.config({
    signs = { severity = min_severity },
    underline = { severity = min_severity },
  })
end

-- Global LSP settings
vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "hs", "spoon" },
      },
    }
  }
})

vim.lsp.config('basedpyright', {
  on_attach = on_attach,
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- use ruff
      analysis = { typeCheckingMode = "off" },
    },
  },
})

-- Setup `ty`, disable diagnostics for python files.
vim.lsp.config('ty', {
  settings = {
    ty = {},
  },
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.py',
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

vim.lsp.config('ts_ls', {
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  on_attach = on_attach,
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
    },
  },
})


vim.lsp.config('gopls', {
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
})

vim.lsp.config('copilot', {})
vim.lsp.enable({ 'lua_ls', 'ty', 'ts_ls', 'gopls', 'copilot' })
