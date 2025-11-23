local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "go",
      "hcl",
      "json",
      "lua",
      "vim",
      "typescript",
      "tsx",
      "python"
    },
    highlight = {
      enable = true,
      -- disable double highlighting
      additional_vim_regex_highlighting = false,
      -- disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = {
      enable = true,
    },
    matchup = {
      enable = true,
    },
    textobjects = {
      swap = {
        enable = true,
        swap_next = {
          ["gl"] = "@parameter.inner"
        },
        swap_previous = {
          ["gh"] = "@parameter.inner"
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["gF"] = "@function.outer",
        },
        goto_previous_start = {
          ["gf"] = "@function.outer",
        },
      },
    },
  })
end

return M
