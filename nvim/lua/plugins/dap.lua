return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>dR",
				function()
					require("dap").restart()
				end,
				desc = "Reiniciar debug",
			},
		},
	},
}
