return {
	{
		"szymonwilczek/vim-be-better",
		cmd = "VimBeBetter",
	},
	{
		"brentsec/VimTeacher",
		cmd = "VimTeacher",
		opts = {
			keymaps = {
				mode = "adaptive_display",
				distro = "auto",
			},
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			disable_mouse = false,
			disabled_keys = {
				["<Up>"] = false,
				["<Down>"] = false,
				["<Left>"] = false,
				["<Right>"] = false,
			},
			restriction_mode = "hint",
		},
	},
}
