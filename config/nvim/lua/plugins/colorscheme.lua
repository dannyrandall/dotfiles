return {
  -- add dracula
  {
	"Mofiqul/dracula.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme dracula]])
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#bd93f9" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#21222c" })
	end
  }
}
