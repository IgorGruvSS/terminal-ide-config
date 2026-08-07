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

			local parsers = {
				"bash",
				"css",
				"go",
				"gomod",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"python",
				"tsx",
				"typescript",
				"vue",
				"yaml",
			}
			local filetypes = vim.list_extend({ "typescriptreact" }, parsers)

			-- The current nvim-treesitter API installs parsers independently from
			-- enabling highlighting. Keeping this list in one place makes a fresh
			-- installation self-contained and covers Vue's injected languages.
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = filetypes,
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}
