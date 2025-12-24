local M = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
  },
  enabled = true,
}

function M.config()
  local codecompanion = require("codecompanion")
  local adapters = require("codecompanion.adapters")
  codecompanion.setup({
    rules = {
      opts = {
        chat = { enabled = false },
      },
    },
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
    interactions = {
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
        slash_commands = {
          ["buffer"] = {
            opts = { provider = "fzf_lua", },
          },
        },
        adapter = {
          name = "anthropic",
          model = "claude-opus-4-5",
        },
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
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          auto_save = true,
          expiration_days = 2,
          picker = "fzf-lua",
        }
      }
    }
  })

  vim.keymap.set({ "n" }, "<LocalLeader>hc", codecompanion.toggle, { noremap = true, silent = true })
end

return M
