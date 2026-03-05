return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter",
	opts = {
		-- brew install rg
		auto_install = true,
	},
}
