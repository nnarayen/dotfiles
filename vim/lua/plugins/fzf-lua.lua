local M = {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
}

function M.config()
  local fzf_lua = require("fzf-lua")

  fzf_lua.setup({
    grep = {
      input_prompt = 'Rg❯ '
    },
    files = {
      actions = {
        ["ctrl-o"] = function(selected, opts)
          fzf_lua.buffers()
        end,
      },
    },
    buffers = {
      actions = {
        ["ctrl-p"] = function(selected, opts)
          fzf_lua.files()
        end,
      },
    },
  })

  vim.keymap.set("n", "<C-p>", function() fzf_lua.files() end, {})
  vim.keymap.set("n", "S", function() fzf_lua.grep_cword() end, {})
  vim.keymap.set("n", "<LocalLeader>a", function() fzf_lua.grep({ no_esc = true }) end, {})
  vim.keymap.set("n", "<LocalLeader>dR", function() fzf_lua.lsp_references() end, {})
  vim.keymap.set("n", "<LocalLeader>m", function() fzf_lua.keymaps() end, {})

  vim.keymap.set("n", "<LocalLeader>gn", function()
    if vim.fs.root(0, { ".git" }) ~= nil then
      fzf_lua.git_branches()
    end
  end)
end

return M
