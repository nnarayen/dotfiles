local M = {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "r", api.fs.rename_sub, opts("Rename"))
  vim.keymap.set("n", "p", api.node.navigate.parent, opts("Parent Directory"))
end

function M.config()
  require("nvim-tree").setup({
    disable_netrw = false,
    view = {
      adaptive_size = true,
    },
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    on_attach = on_attach,
  })
end

function focus_file()
  local api = require("nvim-tree.api")

  api.tree.find_file({
    open = true,
    focus = true,
  })
end

M.keys = {
  { "<LocalLeader>f", focus_file, desc = "Toggle tree" },
}

return M
