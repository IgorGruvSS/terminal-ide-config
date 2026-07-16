return {
	{
		"okuuva/auto-save.nvim",

		config = function()
			require("auto-save").setup({
				enabled = false,
				trigger_events = {
					immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
					defer_save = { "InsertLeave", "TextChanged", "TextChangedI" },
					cancel_deferred_save = { "InsertEnter" },
				},
				debounce_delay = 1500,
			})

			vim.keymap.set("n", "<leader>as", "<cmd>ASToggle<CR>", { desc = "Toggle auto-save" })
		end,
	},
}
