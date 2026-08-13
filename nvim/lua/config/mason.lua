local M = {}

local function wanted_packages()
	local wanted = {}
	local function add(name)
		if name and name ~= "" then
			wanted[name:gsub("@.*$", "")] = true
		end
	end

	for _, tool in ipairs(LazyVim.opts("mason.nvim").ensure_installed or {}) do
		add(tool)
	end

	require("lazy").load({ plugins = { "mason-lspconfig.nvim" } })
	local mapping = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
	for server, opts in pairs(LazyVim.opts("nvim-lspconfig").servers or {}) do
		if server ~= "*" and opts.enabled ~= false then
			add(mapping[server])
		end
	end

	return vim.tbl_keys(wanted)
end

---@param timeout_ms? number
---@return boolean, string[]
function M.install_all(timeout_ms)
	require("lazy").load({ plugins = { "mason.nvim" } })
	local registry = require("mason-registry")
	local packages = wanted_packages()
	local refreshed = false

	registry.refresh(function()
		for _, name in ipairs(packages) do
			local package = registry.get_package(name)
			if not package:is_installed() and not package:is_installing() then
				package:install()
			end
		end
		refreshed = true
	end)

	if not vim.wait(60000, function()
		return refreshed
	end, 100) then
		vim.notify("Mason não conseguiu atualizar o registro.", vim.log.levels.ERROR)
		return false, packages
	end

	local completed = vim.wait(timeout_ms or 300000, function()
		for _, name in ipairs(packages) do
			local package = registry.get_package(name)
			if not package:is_installed() or package:is_installing() then
				return false
			end
		end
		return true
	end, 500)

	local missing = vim.tbl_filter(function(name)
		return not registry.get_package(name):is_installed()
	end, packages)
	table.sort(missing)

	if #missing > 0 then
		local reason = completed and "falha" or "tempo limite excedido"
		vim.notify("Mason: " .. reason .. " ao instalar: " .. table.concat(missing, ", "), vim.log.levels.ERROR)
		return false, missing
	end

	vim.notify("Todas as ferramentas declaradas pelo Mason estão instaladas.", vim.log.levels.INFO)
	return true, {}
end

return M
