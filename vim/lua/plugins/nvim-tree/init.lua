-- custom bindings for nvim-tree
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
	{ key = "p", cb = tree_cb("parent_node") },
	{ key = "r", cb = tree_cb("full_rename") },
}
