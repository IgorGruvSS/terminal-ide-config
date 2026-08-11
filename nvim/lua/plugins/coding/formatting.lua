return {
	{
		"stevearc/conform.nvim",

		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },

					go = { "goimports", "gofmt", stop_after_first = true },

					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					vue = { "prettier" },

					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },

					python = { "black" },
				},

				format_on_save = {
					timeout_ms = 1000,
					lsp_format = "never",
				},

				formatters = {
					prettier = {
						-- Prettier 1.x can return empty output through Neovim's stdin pipe.
						-- Let Conform format a temporary file for compatibility with Vue 2 projects.
						stdin = false,
						args = { "--write", "$FILENAME" },
					},
				},
			})
		end,
	},
}
