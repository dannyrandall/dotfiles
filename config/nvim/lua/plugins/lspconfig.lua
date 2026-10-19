return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		-- server binaries are installed separately -- see "Language servers" in the readme
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
		vim.lsp.enable({ "ty", "jsonls", "marksman", "vtsls", "yamlls" })
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end,
}
