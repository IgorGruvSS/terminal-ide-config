return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 500,
			spec = {
				{ "<leader>a", group = "auto-save" },
				{ "<leader>c", group = "code" },
				{ "<leader>d", group = "diff / diagnostics" },
				{ "<leader>f", group = "find" },
				{ "<leader>r", group = "rename" },
			},
		},
	},
}
