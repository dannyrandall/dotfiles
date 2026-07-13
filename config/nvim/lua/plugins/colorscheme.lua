return {
  {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "auto",
			background = {
				light = "latte",
				dark = "mocha",
			},
		})
		vim.cmd([[colorscheme catppuccin]])
	end
  },
  {
	"f-person/auto-dark-mode.nvim",
	opts = {
		set_dark_mode = function()
			vim.opt.background = "dark"
		end,
		set_light_mode = function()
			vim.opt.background = "light"
		end,
	},
  },
}
