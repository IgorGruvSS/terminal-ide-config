local M = {}

---@param timeout_ms? number
---@return boolean
function M.install_all(timeout_ms)
	require("lazy").load({ plugins = { "nvim-treesitter" } })
	local parsers = LazyVim.opts("nvim-treesitter").ensure_installed or {}
	local ok, installed = pcall(function()
		return require("nvim-treesitter").install(parsers):wait(timeout_ms or 300000)
	end)
	if not ok or installed == false then
		vim.notify("Falha ao instalar parsers Treesitter: " .. tostring(installed), vim.log.levels.ERROR)
		return false
	end
	vim.notify("Todos os parsers Treesitter declarados estão instalados.", vim.log.levels.INFO)
	return true
end

return M
