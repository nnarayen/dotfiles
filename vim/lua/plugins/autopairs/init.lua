-- setup autopairs
local npairs = require('nvim-autopairs')
npairs.setup({
  check_ts = true,
})

-- setup endwise
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
