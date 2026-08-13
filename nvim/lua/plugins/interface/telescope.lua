local function telescope(method, opts)
	return function()
		opts = vim.tbl_deep_extend("force", { cwd = LazyVim.root() }, opts or {})
		require("telescope.builtin")[method](opts)
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>gc", false },
			{ "<leader>ff", telescope("find_files"), desc = "Buscar arquivos" },
			{
				"<leader>fg",
				telescope("live_grep", { additional_args = { "--fixed-strings" } }),
				desc = "Buscar texto literal (ripgrep)",
			},
			{ "<leader>fr", telescope("live_grep"), desc = "Buscar texto regex (ripgrep)" },
			{ "<leader>fb", telescope("buffers", { cwd = nil }), desc = "Listar buffers abertos" },
			{ "<leader>fh", telescope("help_tags", { cwd = nil }), desc = "Buscar ajuda" },
			{ "<leader>fk", telescope("keymaps", { cwd = nil }), desc = "Buscar atalhos" },
		},
	},
}
