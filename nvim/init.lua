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

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "Open working tree diff" })
vim.keymap.set("n", "<leader>df", "<cmd>DiffviewOpen origin/develop...HEAD --imply-local<CR>", { desc = "Open branch diff" })
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })
vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory<CR>", { desc = "Open file history" })
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus file tree" })
