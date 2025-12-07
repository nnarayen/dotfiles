local M = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  enabled = true,
}

function M.config()
  local codecompanion = require("codecompanion")
  local adapters = require("codecompanion.adapters")
  codecompanion.setup({
    adapters = {
      http = {
        baseten = function()
          return adapters.extend("openai_compatible", {
            env = {
              url = "https://inference.baseten.co",
              api_key = "BASETEN_API_KEY",
              chat_url = "/v1/chat/completions",
              models_endpoint = "/v1/models",
            },
            schema = {
              model = {
                default = "openai/gpt-oss-120b",
              },
            },
          })
        end,
      }
    },
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
        adapter = "baseten",
      },
      inline = {
        adapter = "baseten",
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
