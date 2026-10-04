return {
	{
		"stevearc/conform.nvim",
		opts = {
			default_format_opts = {
				timeout_ms = 1000,
				lsp_format = "never",
			},
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
				sql = { "sqlfluff" },
				python = { "black" },
			},
			formatters = {
				prettier = {
					-- File-based formatting also supports project-pinned Prettier 1.x in Vue 2 repositories.
					stdin = false,
					args = { "--write", "$FILENAME" },
				},
				sqlfluff = {
					command = "sqlfluff",
					-- Keep project and nested SQLFluff settings when formatting via stdin.
					args = { "format", "--dialect", "postgres", "--stdin-filename", "$FILENAME", "-" },
					stdin = true,
				},
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = { "black", "debugpy", "prettier", "sqlfluff", "stylua" },
		},
	},
}
