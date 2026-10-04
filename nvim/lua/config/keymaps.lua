local map = vim.keymap.set

-- Keep selection editing close to graphical editors while preserving Vim's
-- operator grammar in Normal mode. Flash is disabled in plugins/editing/flash.lua,
-- so `s` is also the native substitute command outside Visual mode.
map("x", "s", '"_c', { desc = "Substituir seleção sem copiar" })
map("x", "d", '"_d', { desc = "Apagar seleção sem copiar" })
map("x", "x", "d", { desc = "Cortar seleção" })

map("n", "<leader>w", "<cmd>write<CR>", { desc = "Salvar arquivo" })
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
