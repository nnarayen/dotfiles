local M = {
  "nvim-neorg/neorg",
  version = '*',
  enabled = true,
  lazy = false,
}

function M.config()
  local neorg = require("neorg")
  neorg.setup {
    load = {
      ["core.defaults"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            scratch = "~/.neorg/scratch",
          },
          default_workspace = "scratch",
        },
      },
      ["core.concealer"] = {},
      ["core.promo"] = {},
      ["core.keybinds"] = {},
    },
  }

  vim.keymap.set('n', '<localleader>ni', ':Neorg index<CR>', { silent = true })
  vim.keymap.set('n', '<localleader>nv', function()
    vim.cmd('vsplit')
    vim.cmd('Neorg index')
  end, { silent = true })

  -- Neorg specific keybindings
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = "norg",
    callback = function()
      vim.keymap.set('n', '<C-p>', function()
        require('fzf-lua').files({ cwd = vim.fn.expand('~/.neorg') })
      end, { silent = true, buffer = true })

      -- Better folds
      vim.keymap.set('n', '<Tab>', 'za', { buffer = true })

      -- Auto bullet
      vim.keymap.set('i', '<CR>', '<Plug>(neorg.itero.next-iteration)', { buffer = true })
      vim.keymap.set('i', '<S-CR>', '<CR>', { buffer = true })
    end,
  })
end

return M
