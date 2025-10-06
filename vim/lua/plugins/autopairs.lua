local M = {
  "windwp/nvim-autopairs",
  enabled = true,
}

function M.config()
  local Rule = require('nvim-autopairs.rule')
  local npairs = require('nvim-autopairs')
  local cond = require('nvim-autopairs.conds')

  npairs.setup({
    enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
    ignored_next_char = "[%w%.]",      -- will ignore alphanumeric and `.` symbol
  })

  npairs.add_rules({
    Rule("```", "```", { "codecompanion" }):with_pair(cond.not_before_char('`', 3))
  })
end

return M
