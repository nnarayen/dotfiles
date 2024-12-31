local M = {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {}
}

function M.config()
  local fzf_lua = require("fzf-lua")

  vim.keymap.set("n", "<C-p>", function()
    fzf_lua.files()
  end, {})
end

return M
