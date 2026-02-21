local M = {
  "stevearc/dressing.nvim",
  enabled = true,
}

function M.config()
  require("dressing").setup({
    select = {
      backend = { "fzf_lua", "telescope", "builtin" },
    },
  })
end

return M
