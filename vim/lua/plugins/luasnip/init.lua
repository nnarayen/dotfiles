local ls = require("luasnip")

-- convenience variables
local s = ls.snippet
local t = ls.text_node

ls.snippets = {
  go = {
    s("erP", t("errors.Propagate(err)")),
  }
}

-- C-k completes a snippet
vim.api.nvim_set_keymap("i", "<C-k>", "<Plug>luasnip-expand-or-jump", {silent = true})
