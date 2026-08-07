return {
	{
		"neovim/nvim-lspconfig",

		config = function()
			vim.diagnostic.config({
				severity_sort = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				virtual_text = {
					prefix = ">>",
					source = "if_many",
					spacing = 4,
				},
				float = {
					border = "rounded",
					source = "always",
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					local function map(lhs, rhs, desc)
						vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
					end

					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gr", vim.lsp.buf.references, "Go to references")
					map("K", vim.lsp.buf.hover, "Show hover")
					map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("<leader>d", vim.diagnostic.open_float, "Show diagnostic")
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if has_cmp_lsp then
				capabilities = cmp_lsp.default_capabilities(capabilities)
			end

			local function enable_if_executable(server, executable, opts)
				if vim.fn.executable(executable) == 1 then
					opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, opts or {})
					vim.lsp.config(server, opts)

					vim.lsp.enable(server)
				end
			end

			enable_if_executable("gopls", "gopls")
			enable_if_executable("lua_ls", "lua-language-server", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			enable_if_executable("ts_ls", "typescript-language-server")
			enable_if_executable("vue_ls", "vue-language-server")

			if vim.fn.executable("basedpyright") == 1 then
				vim.lsp.config("basedpyright", { capabilities = capabilities })
				vim.lsp.enable("basedpyright")
			else
				enable_if_executable("pyright", "pyright")
			end

			enable_if_executable("jsonls", "vscode-json-language-server")
			enable_if_executable("yamlls", "yaml-language-server")
		end,
	},
}
