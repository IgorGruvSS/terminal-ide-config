return {
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>go", "<cmd>DiffviewOpen<CR>", desc = "Git: abrir diff do working tree" },
			{
				"<leader>gf",
				"<cmd>DiffviewOpen origin/develop...HEAD --imply-local<CR>",
				desc = "Git: diff contra origin/develop",
			},
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git: histórico do arquivo" },
			{ "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "Git: fechar Diffview" },
		},
	},
}
