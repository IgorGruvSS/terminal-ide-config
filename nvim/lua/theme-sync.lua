-- The terminal selector is intentionally shared by every Neovim instance, so
-- keep it in XDG_STATE_HOME rather than Neovim's application-specific folder.
local state_root = vim.env.XDG_STATE_HOME or vim.fn.fnamemodify(vim.fn.stdpath("state"), ":h")
local state_file = state_root .. "/alacritty-theme"

local profiles = {
	aura = { light = "PaperColor", dark = "aura-dark" },
	alabaster = { light = "alabaster", dark = "PaperColor" },
	modus = { light = "modus_operandi", dark = "modus_vivendi" },
	flexoki = { light = "flexoki-light", dark = "flexoki-dark" },
	github = { light = "github_light", dark = "github_dark" },
	catppuccin = { light = "catppuccin-latte", dark = "catppuccin-macchiato" },
}

local last_state = nil

local function read_state()
	local file = io.open(state_file, "r")
	if not file then
		return nil
	end

	local profile, mode = file:read("*l"), file:read("*l")
	file:close()
	if profiles[profile] and (mode == "light" or mode == "dark") then
		return profile, mode
	end
end

local function apply(profile, mode)
	local scheme = profiles[profile][mode]
	vim.o.background = mode
	vim.cmd.colorscheme(scheme)
	last_state = profile .. ":" .. mode
end

local function sync(force)
	local profile, mode = read_state()
	if not profile then
		-- No terminal selection yet: preserve Neovim's native background default.
		profile, mode = "aura", vim.o.background
	end

	local state = profile .. ":" .. mode
	if force or state ~= last_state then
		apply(profile, mode)
	end
end

vim.api.nvim_create_user_command("ThemeSync", function()
	sync(true)
end, { desc = "Sync Neovim colorscheme with Alacritty theme selection" })

vim.api.nvim_create_user_command("ThemeCurrent", function()
	local profile, mode = read_state()
	if profile then
		vim.notify(string.format("Alacritty profile: %s (%s)", profile, mode))
	else
		vim.notify("Alacritty profile unset; using Neovim background fallback")
	end
end, { desc = "Show the active terminal theme profile" })

sync(true)

vim.api.nvim_create_autocmd("FocusGained", {
	callback = function()
		sync(false)
	end,
	desc = "Refresh colorscheme after an Alacritty theme change",
})
