return {
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGitCurrentFile<cr>", desc = "Open LazyGit" },
		},
		init = function()
			if vim.v.servername == "" then
				local socket = vim.fn.stdpath("state") .. "/lazygit-nvim-" .. vim.fn.getpid() .. ".sock"
				pcall(vim.fn.serverstart, socket)
			end

			vim.g.lazygit_floating_window_scaling_factor = 0.95
			vim.g.lazygit_floating_window_use_plenary = 1
			vim.g.lazygit_use_neovim_remote = 0
		end,
	},
}
