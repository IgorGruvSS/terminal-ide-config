-- The terminal selector is intentionally shared by every Neovim instance, so
-- keep it in XDG_STATE_HOME rather than Neovim's application-specific folder.
local state_root = vim.env.XDG_STATE_HOME or vim.fn.fnamemodify(vim.fn.stdpath("state"), ":h")
local state_file = state_root .. "/alacritty-theme"

local schemes = { light = "catppuccin-latte", dark = "catppuccin-macchiato" }

local last_mode = nil

local function read_mode()
	local file = io.open(state_file, "r")
	if not file then
		return nil
	end

	local first, second = file:read("*l"), file:read("*l")
	file:close()
	-- Accept the former two-line `catppuccin`/mode state while users transition
	-- to the single-mode selector.
	local mode = first == "catppuccin" and second or first
	if schemes[mode] then
		return mode
	end
end

local function apply(mode)
	vim.o.background = mode
	vim.cmd.colorscheme(schemes[mode])
	last_mode = mode
end

local function sync(force)
	local mode = read_mode()
	if not mode then
		-- No terminal selection yet: preserve Neovim's native background default.
		mode = vim.o.background
	end

	if force or mode ~= last_mode then
		apply(mode)
	end
end

vim.api.nvim_create_user_command("ThemeSync", function()
	sync(true)
end, { desc = "Sync Neovim colorscheme with Alacritty theme selection" })

vim.api.nvim_create_user_command("ThemeCurrent", function()
	local mode = read_mode()
	if mode then
		vim.notify(string.format("Catppuccin mode: %s", mode))
	else
		vim.notify("Catppuccin mode unset; using Neovim background fallback")
	end
end, { desc = "Show the active Catppuccin mode" })

-- This module loads immediately after the LazyVim bootstrap. Applying a
-- colorscheme inline can re-enter lazy.nvim while that bootstrap is still
-- completing, especially while the TUI is resolving its background color.
-- Run the initial sync on the next event-loop turn; explicit commands and
-- later FocusGained events remain immediate.
vim.schedule(function()
	sync(true)
end)

vim.api.nvim_create_autocmd("FocusGained", {
	callback = function()
		sync(false)
	end,
	desc = "Refresh colorscheme after an Alacritty theme change",
})
