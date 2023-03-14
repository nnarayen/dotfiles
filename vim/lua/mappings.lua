local map = vim.keymap.set
local default_options = { silent = true }
local expr_options = { expr = true, silent = true }
local noremap_options = { noremap = true }

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)
map("v", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("v", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- Easily move to start/end of line
map("n", "H", "^", default_options)
map("v", "H", "^", default_options)
map("o", "H", "^", default_options)
map("n", "L", "$", default_options)
map("v", "L", "$", default_options)
map("o", "L", "$", default_options)

-- Typos command line
map("c", "W", "w", noremap_options)
map("c", "Q", "q", noremap_options)
map("c", "WQ", "wq", noremap_options)
map("c", "Wq", "wq", noremap_options)
map("c", "wQ", "wq", noremap_options)

-- Avoid ex mode
map("n", "Q", "<nop>", default_options)

-- Sort lines
map("v", "<LocalLeader>S", ":sort<CR>", default_options)

-- Search word under cursor
map("n", "<LocalLeader>s", "*", default_options)

-- Easy exit insert mode
map("i", "jk", "<Esc>", default_options)

-- Easier to run commands
map("n", ";", ":", noremap_options)
map("v", ";", ":", noremap_options)

-- File switching
map("n", "<LocalLeader><LocalLeader>", "<c-^>", default_options)

-- Unhighlight text
map("n", "<LocalLeader>q", ":nohlsearch<CR>")

-- Update buffer
map("n", "<LocalLeader>r", ":checktime<CR>")

-----------------------------------------------------
-- FZF
-----------------------------------------------------
map("n", "<C-p>", ":FZF -m<CR>", default_options)
map("n", "<LocalLeader>a", ":Rg<Space>", noremap_options)

-----------------------------------------------------
-- Vim Swap
-----------------------------------------------------
map("n", "gh", "<Plug>(swap-prev)", default_options)
map("n", "gl", "<Plug>(swap-next)", default_options)

-----------------------------------------------------
-- Lazy
-----------------------------------------------------
map("n", "<LocalLeader>L", ":Lazy<CR>", default_options)
