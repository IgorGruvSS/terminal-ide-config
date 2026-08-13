vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keep the established completion, picker, and Python choices when enabling Extras.
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "nvim-cmp"
vim.g.lazyvim_python_lsp = "basedpyright"

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.updatetime = 1000
vim.opt.confirm = true
vim.opt.list = true
vim.opt.spell = true
vim.opt.spelllang = { "pt_br", "en_us" }
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}
