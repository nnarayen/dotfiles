local nvim_lsp = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Function to organize imports
function organize_imports(wait_ms)
  vim.lsp.buf.code_action({
    context = {
      only = {
        "source.organizeImports",
        -- typescript distinguishes between organize and add
        "source.addMissingImports",
      }
    },
    apply = true,
  })
end


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  local opts = { silent=true, buffer=bufnr }

  vim.keymap.set('n', '<LocalLeader>x', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<LocalLeader>dr', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<LocalLeader>dR', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<LocalLeader>di', function() organize_imports(3000) end, opts)
  vim.keymap.set('n', '<LocalLeader>do', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<LocalLeader>dn', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<LocalLeader>dp', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<LocalLeader>v', vim.lsp.buf.format, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
nvim_lsp.gopls.setup {
  on_attach = on_attach,
  -- Add additional capabilities supported by nvim-cmp
  capabilities = capabilities,
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  -- Add additional capabilities supported by nvim-cmp
  capabilities = capabilities,
}
