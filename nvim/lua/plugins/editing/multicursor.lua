return {
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			vim.keymap.set({ "n", "x" }, "<M-d>", function()
				mc.matchAddCursor(1)
			end, { desc = "Adicionar próxima ocorrência" })

			vim.keymap.set({ "n", "x" }, "<M-D>", function()
				mc.matchSkipCursor(1)
			end, { desc = "Pular próxima ocorrência" })

			mc.addKeymapLayer(function(layer)
				layer("n", "<Esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)
		end,
	},
}
