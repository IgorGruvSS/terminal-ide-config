return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",

		config = function(plugin)
			-- The rewritten nvim-treesitter keeps its queries under runtime/.
			-- Load them from the plugin inside this repository instead of relying on
			-- generated query symlinks that break when the repository is moved.
			vim.opt.rtp:prepend(plugin.dir .. "/runtime")

			local languages = {
				"bash",
				"css",
				"go",
				"gomod",
				"javascript",
				"json",
				"lua",
				"markdown",
				"python",
				"typescript",
				"typescriptreact",
				"yaml",
			}

			require("nvim-treesitter").setup()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}
