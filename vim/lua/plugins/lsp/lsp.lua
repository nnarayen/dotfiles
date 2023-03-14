local nvim_lsp = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Function to organize go imports
function organize_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
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
  capabilities = capabilities
}
