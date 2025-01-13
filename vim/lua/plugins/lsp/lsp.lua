local nvim_lsp = require("lspconfig")

-- Function to organize imports
function organize_imports(wait_ms)
  vim.lsp.buf.code_action({
    context = {
      only = {
        "source.addMissingImports",
      },
    },
    apply = true,
  })
end

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

  -- imports
  vim.keymap.set("n", "<LocalLeader>di", function()
    organize_imports(3000)
  end, opts)

  -- diagnostics, only warn/error
  vim.keymap.set("n", "<LocalLeader>dn", function()
    vim.diagnostic.goto_prev({ severity = min_severity })
  end, opts)
  vim.keymap.set("n", "<LocalLeader>dp", function()
    vim.diagnostic.goto_next({ severity = min_severity })
  end, opts)

  -- enable diagnosts for warn/error only
  vim.diagnostic.config({
    virtual_text = { severity = min_severity },
    signs = { severity = min_severity },
    underline = { severity = min_severity },
  })
end

local capabilities = require("blink.cmp").get_lsp_capabilities()
nvim_lsp.lua_ls.setup({
  on_attach = on_attach,
  -- Add additional capabilities supported by nvim-cmp
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "hs", "spoon" },
      },
    }
  }
})

nvim_lsp.basedpyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- use isort
      analysis = {
        typeCheckingMode = "off"
      }
    },
  },
})

nvim_lsp.ts_ls.setup({
  on_attach = on_attach,
  -- Add additional capabilities supported by nvim-cmp
  capabilities = capabilities,
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
    },
  },
})
