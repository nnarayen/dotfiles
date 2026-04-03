local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
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

  -- Enable treesitter highlighting for buffers with an installed parser
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
      if lang and vim.treesitter.language.add(lang) then
        vim.treesitter.start(args.buf)
      end
    end,
  })

  -- Textobjects
  require("nvim-treesitter-textobjects").setup({
    swap = {
      enable = true,
      swap_next = { ["gl"] = "@parameter.inner" },
      swap_previous = { ["gh"] = "@parameter.inner" },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = { ["gF"] = "@function.outer" },
      goto_previous_start = { ["gf"] = "@function.outer" },
    },
  })
end

return M
