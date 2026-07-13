-- auto-dark-mode.nvim needs the OS to expose light/dark: macOS natively, or a
-- Linux desktop with dbus-send. Computed once here and reused below.
local auto_dark_mode_supported = vim.fn.has("mac") == 1 or vim.fn.executable("dbus-send") == 1

-- Non-blocking nudge (once per session) if it can't run because dbus-send is
-- missing on Linux. Runs when lazy imports this spec; deferred so it shows as a
-- bottom-line warning after startup, not an error.
if not auto_dark_mode_supported then
	vim.schedule(function()
		vim.notify(
			"auto-dark-mode.nvim disabled: 'dbus-send' not found — install 'dbus-tools' to enable OS light/dark detection",
			vim.log.levels.WARN
		)
	end)
end

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
	-- skipped on headless/dev hosts (no dbus-send) to avoid errors; see above
	enabled = auto_dark_mode_supported,
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
