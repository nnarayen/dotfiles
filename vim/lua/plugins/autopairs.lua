local M = {
  "windwp/nvim-autopairs",
}

function M.config()
  require("nvim-autopairs").setup({
    enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
  })
end

return M
