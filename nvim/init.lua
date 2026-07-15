vim.g.mapleader = " "

vim.opt.number = true
-- Re-enable when using relative motions often, e.g. 5j, 3k, d4j.
-- vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.updatetime = 1000
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.cmd.colorscheme("aura-dark")

local function apply_custom_highlights()
	vim.api.nvim_set_hl(0, "@tag", { fg = "#61ffca" })
	vim.api.nvim_set_hl(0, "@tag.tsx", { fg = "#61ffca" })
	vim.api.nvim_set_hl(0, "@tag.javascript", { fg = "#61ffca" })
	vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#a277ff" })
	vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { fg = "#a277ff" })
	vim.api.nvim_set_hl(0, "@tag.attribute.javascript", { fg = "#a277ff" })
	vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#6d6d6d" })
	vim.api.nvim_set_hl(0, "@tag.delimiter.tsx", { fg = "#6d6d6d" })
	vim.api.nvim_set_hl(0, "@tag.delimiter.javascript", { fg = "#6d6d6d" })
end

apply_custom_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = apply_custom_highlights,
})

local external_changes_group = vim.api.nvim_create_augroup("external_file_changes", { clear = true })

local function check_external_changes()
	if vim.fn.mode() == "c" or vim.fn.getcmdwintype() ~= "" then
		return
	end

	vim.cmd.checktime()
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = external_changes_group,
	callback = check_external_changes,
	desc = "Check for files changed outside Neovim",
})

vim.api.nvim_create_autocmd("FileChangedShell", {
	group = external_changes_group,
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
	desc = "Warn before resolving an external file conflict",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = external_changes_group,
	callback = function(args)
		if vim.v.fcs_reason == "changed" then
			local file = vim.fn.fnamemodify(args.file, ":~:.")
			vim.notify("Arquivo atualizado externamente\n" .. file, vim.log.levels.INFO, {
				title = "Alteração externa",
			})
		end
	end,
	desc = "Notify after reloading an externally changed file",
})

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "Open working tree diff" })
vim.keymap.set("n", "<leader>df", "<cmd>DiffviewOpen origin/develop...HEAD --imply-local<CR>", { desc = "Open branch diff" })
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })
vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory<CR>", { desc = "Open file history" })
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus file tree" })
