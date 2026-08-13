return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{
				"<leader>e",
				"<cmd>Neotree toggle reveal<CR>",
				desc = "Alternar Neo-tree",
			},
			{
				"<leader>o",
				"<cmd>Neotree focus reveal<CR>",
				desc = "Focar Neo-tree",
			},
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				follow_current_file = { enabled = true },
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
	},
}
