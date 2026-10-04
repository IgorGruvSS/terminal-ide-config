return {
	-- LazyVim enables Snacks' own indentation renderer by default. IBL is the
	-- single renderer here because it supplies the per-level rainbow colours.
	{
		"folke/snacks.nvim",
		opts = {
			indent = { enabled = false },
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			vim.g.rainbow_delimiters = {
				query = {
					javascript = "rainbow-parens",
					tsx = "rainbow-parens",
				},
			}
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		dependencies = { "HiPhish/rainbow-delimiters.nvim", "catppuccin/nvim" },
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowPeach",
				"RainbowGreen",
				"RainbowMauve",
				"RainbowTeal",
			}
			local hooks = require("ibl.hooks")

			-- Recreate the groups after every Catppuccin flavour change, keeping
			-- indentation, active scope, and rainbow delimiters in sync.
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				local palette = require("catppuccin.palettes").get_palette()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = palette.red })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = palette.yellow })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = palette.blue })
				vim.api.nvim_set_hl(0, "RainbowPeach", { fg = palette.peach })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = palette.green })
				vim.api.nvim_set_hl(0, "RainbowMauve", { fg = palette.mauve })
				vim.api.nvim_set_hl(0, "RainbowTeal", { fg = palette.teal })
			end)

			vim.g.rainbow_delimiters = vim.tbl_deep_extend("force", vim.g.rainbow_delimiters or {}, {
				highlight = highlight,
			})

			require("ibl").setup({
				indent = { char = "│", tab_char = "│", highlight = highlight },
				scope = { enabled = true, highlight = highlight },
			})
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
}
