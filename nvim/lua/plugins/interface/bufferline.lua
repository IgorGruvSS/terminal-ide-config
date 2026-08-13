return {
	{
		"akinsho/bufferline.nvim",
		keys = {
			{
				"<leader>bd",
				function()
					require("config.buffers").close(0)
				end,
				desc = "Fechar buffer com segurança",
			},
			{
				"<leader>bo",
				function()
					require("config.buffers").close_others()
				end,
				desc = "Fechar outros buffers com segurança",
			},
		},
		opts = {
			options = {
				always_show_bufferline = true,
				diagnostics = "nvim_lsp",
			},
		},
	},
}
