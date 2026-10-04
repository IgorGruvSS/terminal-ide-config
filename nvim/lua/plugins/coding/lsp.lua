local function local_vue_server(root_dir)
	if not root_dir then
		return nil
	end
	local package = vim.fs.joinpath(root_dir, "node_modules", "@vue", "language-server")
	return vim.uv.fs_stat(package) and package or nil
end

return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			-- Keep diagnostics and inferred types available without rendering them
			-- inside the code. Use <leader>d for a diagnostic and K for LSP hover.
			opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
				virtual_text = false,
				virtual_lines = false,
			})
			opts.inlay_hints = vim.tbl_deep_extend("force", opts.inlay_hints or {}, {
				enabled = false,
			})

			opts.servers = opts.servers or {}
			opts.servers["*"] = vim.tbl_deep_extend("force", opts.servers["*"] or {}, {
				keys = {
					{ "gd", vim.lsp.buf.definition, desc = "Ir para definição" },
					{ "gr", vim.lsp.buf.references, desc = "Listar referências" },
					{ "K", vim.lsp.buf.hover, desc = "Mostrar documentação" },
					{ "<leader>ca", vim.lsp.buf.code_action, desc = "Ação de código", has = "codeAction" },
				},
			})

			-- Prefer the project-pinned Vue language tools. Vue 2 requires the
			-- maintained 3.0.x line; projects without a local copy use Mason's current version.
			local vtsls = opts.servers.vtsls or {}
			local previous_before_init = vtsls.before_init
			vtsls.before_init = function(params, config)
				if previous_before_init then
					previous_before_init(params, config)
				end
				local package = local_vue_server(config.root_dir)
				if not package then
					return
				end
				local settings = config.settings and config.settings.vtsls
				local tsserver = settings and settings.tsserver
				for _, plugin in ipairs((tsserver and tsserver.globalPlugins) or {}) do
					if plugin.name == "@vue/typescript-plugin" then
						plugin.location = package
					end
				end
			end
			opts.servers.vtsls = vtsls

			local vue_ls = opts.servers.vue_ls or {}
			vue_ls.cmd = function(dispatchers, config)
				local package = local_vue_server(config.root_dir)
				local command = package and vim.fs.joinpath(package, "bin", "vue-language-server.js")
				if command and vim.uv.fs_stat(command) then
					return vim.lsp.rpc.start({ vim.fn.exepath("node"), command, "--stdio" }, dispatchers)
				end
				return vim.lsp.rpc.start({ "vue-language-server", "--stdio" }, dispatchers)
			end
			opts.servers.vue_ls = vue_ls

			-- Keep pyright installed and configured as a quiet fallback. It is
			-- enabled only when basedpyright is unavailable, so both never attach.
			opts.servers.pyright = opts.servers.pyright or {}
			opts.servers.pyright.enabled = true
			opts.setup = opts.setup or {}
			opts.setup.pyright = function(_, server_opts)
				vim.lsp.config("pyright", server_opts)
				if vim.fn.executable("basedpyright-langserver") ~= 1 then
					vim.lsp.enable("pyright")
				end
				return true
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "pyright" } },
	},
}
