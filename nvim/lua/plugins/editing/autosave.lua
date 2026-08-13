return {
	{
		"okuuva/auto-save.nvim",
		dependencies = { "stevearc/conform.nvim" },

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

			-- auto-save writes from inside another autocmd, so Neovim does not run
			-- nested BufWritePre handlers. Format explicitly before that write.
			local group = vim.api.nvim_create_augroup("AutoSaveFormat", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "AutoSaveWritePre",
				callback = function(event)
					local buf = event.data and event.data.saved_buffer
					if buf and LazyVim.format.enabled(buf) then
						require("conform").format({ bufnr = buf })
					end
				end,
				desc = "Formatar antes da gravação automática",
			})

			vim.keymap.set("n", "<leader>as", "<cmd>ASToggle<CR>", { desc = "Alternar auto-save" })
		end,
	},
}
