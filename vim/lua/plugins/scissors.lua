local M = {
  "chrisgrieser/nvim-scissors",
}

function M.config()
  require("scissors").setup({
    snippetDir = vim.fn.stdpath("config") .. "/snippets",
    jsonFormatter = "jq", -- "yq"|"jq"|"none"
  })

  vim.keymap.set("n", "<LocalLeader>E", function()
    require("scissors").editSnippet()
  end)
  vim.keymap.set({ "n", "x" }, "<LocalLeader>S", function()
    require("scissors").addNewSnippet()
  end)
end

return M
