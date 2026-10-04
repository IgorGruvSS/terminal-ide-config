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
			source_selector = {
				winbar = true,
				content_layout = "center",
				sources = {
					{ source = "filesystem", display_name = " 󰉓 Files " },
					{ source = "buffers", display_name = " 󰈚 Buffers " },
					{ source = "git_status", display_name = " 󰊢 Git " },
				},
			},
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
