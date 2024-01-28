local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
  },
}

function M.config()
  local ls = require("luasnip")

  -- expansion key
  -- this will expand the current item or jump to the next item within the snippet.
  vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })

  -- jump backwards key.
  -- this always moves to the previous item within the snippet
  vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true })

  -- load all snippets
  require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

  -- convenience variables
  local s = ls.snippet
  local t = ls.text_node

  ls.add_snippets("go", {
    s("erP", t("errors.Propagate(err)")),
    s("tdT", {
      t({
        "for _, tt := range []struct {",
        "\tname string",
        "}{",
        "\t{},",
        "} {",
        "\tt.Run(tt.name, func(t *testing.T) {",
        "\t})",
        "}",
      }),
    }),
  })
end

return M
