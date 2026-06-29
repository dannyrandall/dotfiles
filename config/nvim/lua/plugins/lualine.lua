return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "dracula",
			disabled_filetypes = {
				statusline = { "neo-tree", "DiffviewFiles", "DiffviewFileHistory" },
			},
		},
		sections = {
			lualine_c = {
				{ "filename", path = 1 },
				{ function() return vim.b.gitsigns_blame_line or "" end, icon = "" },
			},
		},
	},
}
