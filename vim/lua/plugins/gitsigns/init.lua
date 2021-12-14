require('gitsigns').setup {
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n <LocalLeader>hn'] = '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>',
    ['n <LocalLeader>hp'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>',
    ['n <LocalLeader>hu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <LocalLeader>hu'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  },
}
