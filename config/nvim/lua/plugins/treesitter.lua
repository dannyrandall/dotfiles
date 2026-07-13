return {
	"nvim-treesitter/nvim-treesitter",
	-- The repo was archived (Apr 2026). `master` is frozen (targets nvim 0.11);
	-- `main` is the incompatible rewrite for nvim 0.12+, which we run.
	branch = "main",
	lazy = false, -- main branch does not support lazy-loading
	build = ":TSUpdate", -- requires the tree-sitter CLI: `brew install tree-sitter-cli`
	config = function()
		require("nvim-treesitter").setup()

		-- Parsers to keep installed (main branch has no `auto_install`).
		-- `install` is async and a no-op for parsers already present.
		require("nvim-treesitter").install({
			"bash",
			"c",
			"diff",
			"dockerfile",
			"git_config",
			"git_rebase",
			"gitcommit",
			"gitignore",
			"go",
			"javascript",
			"json",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
			"zsh",
		})

		-- The rewrite does not auto-enable highlighting; start it per buffer.
		-- If starting fails, nudge once (non-blocking) but only when a parser is
		-- actually installable for that filetype -- so missing languages are
		-- discoverable without the noisy errors, and scratch/UI buffers stay quiet.
		local warned = {}
		local available -- cached list of installable parsers (lazily fetched)
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				if pcall(vim.treesitter.start, args.buf) then
					return
				end
				local lang = vim.treesitter.language.get_lang(args.match) or args.match
				if warned[lang] then
					return
				end
				available = available or require("nvim-treesitter").get_available()
				if vim.list_contains(available, lang) then
					warned[lang] = true
					vim.schedule(function()
						vim.notify(
							("treesitter: no parser for '%s' — run :TSInstall %s to enable highlighting"):format(lang, lang),
							vim.log.levels.WARN
						)
					end)
				end
			end,
		})
	end,
}
