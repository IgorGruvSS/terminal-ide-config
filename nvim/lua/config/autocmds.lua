local external_changes = vim.api.nvim_create_augroup("external_file_changes", { clear = true })

local function check_external_changes()
	if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
		vim.cmd.checktime()
	end
end

-- LazyVim already checks for external changes on FocusGained. Keep the extra
-- checks while editing so autoread also notices updates without changing focus.
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = external_changes,
	callback = check_external_changes,
	desc = "Verificar alterações externas nos arquivos",
})

vim.api.nvim_create_autocmd("FileChangedShell", {
	group = external_changes,
	callback = function(args)
		vim.v.fcs_choice = "ask"
		if vim.v.fcs_reason == "conflict" then
			local file = vim.fn.fnamemodify(args.file, ":~:.")
			vim.notify(
				"CONFLITO: o arquivo mudou no disco e este buffer possui alterações locais\n" .. file,
				vim.log.levels.ERROR,
				{ title = "Alteração externa" }
			)
		end
	end,
	desc = "Proteger alterações locais de mudanças externas",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = external_changes,
	callback = function(args)
		if vim.v.fcs_reason == "changed" then
			local file = vim.fn.fnamemodify(args.file, ":~:.")
			vim.notify("Arquivo atualizado externamente\n" .. file, vim.log.levels.INFO, {
				title = "Alteração externa",
			})
		end
	end,
	desc = "Notificar recarga de arquivo alterado externamente",
})
