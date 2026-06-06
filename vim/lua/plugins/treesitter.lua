local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  enabled = true,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  },
}

function M.config()
  require("nvim-treesitter").install({
    "bash",
    "go",
    "gomod",
    "gosum",
    "hcl",
    "json",
    "lua",
    "vim",
    "vimdoc",
    "typescript",
    "tsx",
    "python",
    "yaml",
  })

  -- Highlighting: start treesitter for any buffer whose parser is installed.
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
      if not lang then
        return
      end
      local ok, added = pcall(vim.treesitter.language.add, lang)
      if ok and added then
        vim.treesitter.start(args.buf, lang)
      end
    end,
  })

  require("nvim-treesitter-textobjects").setup({
    move = { set_jumps = true },
  })

  local swap = require("nvim-treesitter-textobjects.swap")
  local move = require("nvim-treesitter-textobjects.move")

  -- Swap parameters
  vim.keymap.set("n", "gl", function()
    swap.swap_next("@parameter.inner")
  end, { desc = "Swap with next parameter" })
  vim.keymap.set("n", "gh", function()
    swap.swap_previous("@parameter.inner")
  end, { desc = "Swap with previous parameter" })

  -- Move between functions
  vim.keymap.set({ "n", "x", "o" }, "gF", function()
    move.goto_next_start("@function.outer", "textobjects")
  end, { desc = "Next function start" })
  vim.keymap.set({ "n", "x", "o" }, "gf", function()
    move.goto_previous_start("@function.outer", "textobjects")
  end, { desc = "Previous function start" })
end

return M
