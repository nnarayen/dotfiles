local M = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

function M.config()
  codecompanion = require("codecompanion")
  codecompanion.setup({
    strategies = {
      chat = {
        keymaps = {
          send = {
            modes = { i = "<S-CR>" },
          },
          close = {
            modes = { n = "<Esc>" },
          },
          clear = {
            -- Override clear behavior to start a new chat
            callback = function()
              codecompanion.chat()
            end,
          }
        },
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
    display = {
      chat = {
        -- Options to customize the UI of the chat buffer
        window = {
          width = 0.3,
        },
      },
    },
  })

  vim.keymap.set({ "n", "v" }, "<LocalLeader>ch", codecompanion.toggle, { noremap = true, silent = true })
  vim.keymap.set({ "n", "v" }, "<LocalLeader>ci", ":CodeCompanion ", { noremap = true })

  -- Expand 'cc' into 'CodeCompanion' in the command line
  vim.cmd([[cab cc CodeCompanion]])
end

return M
