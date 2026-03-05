return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			mappings = {
				i = {
					["<C-f>"] = "close",
				},
				n = {
					["<C-f>"] = "close",
				},
			},
		},
	},
}
