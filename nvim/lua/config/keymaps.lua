local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<CR>", { desc = "Salvar arquivo" })
map("n", "<leader>e", "<cmd>Neotree toggle reveal<CR>", { desc = "Alternar Neo-tree" })
map("n", "<leader>o", "<cmd>Neotree focus reveal<CR>", { desc = "Focar Neo-tree" })
map("n", "<leader>bd", function()
	require("config.buffers").close(0)
end, { desc = "Fechar buffer com segurança" })
map("n", "<leader>bo", function()
	require("config.buffers").close_others()
end, { desc = "Fechar outros buffers com segurança" })

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renomear símbolo" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Mostrar diagnóstico" })

local function copy_current_file_path(modifier, description)
	local path = vim.fn.expand("%:" .. modifier)
	if path == "" then
		vim.notify("O buffer atual não possui um arquivo", vim.log.levels.WARN)
		return
	end
	vim.fn.setreg("+", path)
	vim.notify("Copiado: " .. path, vim.log.levels.INFO, { title = description })
end

map("n", "<leader>yp", function()
	copy_current_file_path("p", "Caminho absoluto")
end, { desc = "Copiar caminho absoluto" })
map("n", "<leader>yr", function()
	copy_current_file_path(".", "Caminho relativo")
end, { desc = "Copiar caminho relativo" })
