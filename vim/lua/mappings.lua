local map = vim.keymap.set
local default_options = { silent = true }
local expr_options = { expr = true, silent = true }

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

-- Avoid ex mode
map("n", "Q", "<nop>", default_options)

-- Sort lines
map("v", "<LocalLeader>S", ":sort<CR>", default_options)

-- Search word under cursor
map("n", "<LocalLeader>s", "*", default_options)

-- Easy exit insert mode
-- map("i", "jk", "<Esc>", default_options)

-- Easier to run commands
map("n", ";", ":")
map("v", ";", ":")

-- File switching
map("n", "<LocalLeader><LocalLeader>", "<c-^>", default_options)

-- Unhighlight text
map("n", "<LocalLeader>q", ":nohlsearch<CR>", default_options)

-- Update buffer
map("n", "<LocalLeader>r", ":checktime<CR>", default_options)

-- Search for word under cursor
map("n", "S", ":Rg <C-R><C-W><CR>", default_options)

-- Copy relative/absolute file paths
map("n", "<LocalLeader>u", ":let @+=expand('%')<CR>", default_options)
map("n", "<LocalLeader>U", ":let @+=expand('%:p')<CR>", default_options)

-- Command typos
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev wQ wq")

-- Extract command for go test
function extract_filename()
  local filename = vim.fn.getreg("+")
  local directory = vim.fn.expand("%:p:.:h")
  vim.fn.setreg("+", "go test ./" .. directory .. " vR " .. filename)
end

map("n", "<LocalLeader>gT", extract_filename, default_options)

-----------------------------------------------------
-- FZF
-----------------------------------------------------
-- map("n", "<C-p>", ":FZF -m<CR>", default_options)
map("n", "<LocalLeader>a", ":Rg<Space>")

-----------------------------------------------------
-- Vim Swap
-----------------------------------------------------
map("n", "gh", "<Plug>(swap-prev)", default_options)
map("n", "gl", "<Plug>(swap-next)", default_options)

-----------------------------------------------------
-- Lazy
-----------------------------------------------------
map("n", "<LocalLeader>L", ":Lazy<CR>", default_options)
