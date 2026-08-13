vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keep the established completion, picker, and Python choices when enabling Extras.
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "nvim-cmp"
vim.g.lazyvim_python_lsp = "basedpyright"

vim.opt.relativenumber = false
vim.opt.scrolloff = 8
vim.opt.autoread = true
vim.opt.updatetime = 1000
vim.opt.spell = true
vim.opt.spelllang = { "pt_br", "en_us" }
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}
