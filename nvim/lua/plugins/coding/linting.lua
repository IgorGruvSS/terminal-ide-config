return {
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			opts.linters = opts.linters or {}
			opts.linters.sqlfluff = function()
				local linter = vim.deepcopy(require("lint.linters.sqlfluff"))
				local filename = vim.api.nvim_buf_get_name(0)

				linter.args = {
					"lint",
					"--format=json",
					"-",
				}

				if filename ~= "" then
					local dirname = vim.fs.dirname(filename)
					if dirname and vim.fn.isdirectory(dirname) == 1 then
						linter.cwd = dirname
						table.insert(linter.args, 3, "--stdin-filename")
						table.insert(linter.args, 4, filename)
					end
				end

				return linter
			end
		end,
	},
}
