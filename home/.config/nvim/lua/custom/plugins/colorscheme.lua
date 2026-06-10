Gruvbox = {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	opts = {
		transparent_mode = true,
	},
	init = function()
		vim.cmd.colorscheme("gruvbox")
		vim.cmd.hi("Comment gui=none")
	end,
}
TokyoNight = {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
	},
	init = function()
		vim.cmd.colorscheme("tokyonight")
		vim.cmd.hi("Comment gui=none")
	end,
}
RosePine = {
	"rose-pine/neovim",
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "auto",   -- auto, main, moon, or dawn
			dark_variant = "main", -- main, moon, or dawn
			dim_inactive_windows = false,
			extend_background_behind_borders = true,

			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true,    -- Handle deprecated options automatically
			},

			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},

			groups = {
				border = "muted",
				link = "iris",
				panel = "surface",

				error = "love",
				hint = "iris",
				info = "foam",
				note = "pine",
				todo = "rose",
				warn = "gold",

				git_add = "foam",
				git_change = "rose",
				git_delete = "love",
				git_dirty = "rose",
				git_ignore = "muted",
				git_merge = "iris",
				git_rename = "pine",
				git_stage = "iris",
				git_text = "rose",
				git_untracked = "subtle",

				h1 = "iris",
				h2 = "foam",
				h3 = "rose",
				h4 = "gold",
				h5 = "pine",
				h6 = "foam",
			},

			palette = {
				-- Override the builtin palette per variant
				-- moon = {
				--     base = '#18191a',
				--     overlay = '#363738',
				-- },
			},

			-- NOTE: Highlight groups are extended (merged) by default. Disable this
			-- per group via `inherit = false`
			highlight_groups = {
				-- Comment = { fg = "foam" },
				-- StatusLine = { fg = "love", bg = "love", blend = 15 },
				-- VertSplit = { fg = "muted", bg = "muted" },
				-- Visual = { fg = "base", bg = "text", inherit = false },
			},

			before_highlight = function(group, highlight, palette)
				-- Disable all undercurls
				-- if highlight.undercurl then
				--     highlight.undercurl = false
				-- end
				--
				-- Change palette colour
				-- if highlight.fg == palette.pine then
				--     highlight.fg = palette.foam
				-- end
			end,
		})

		-- vim.cmd("colorscheme rose-pine")
		-- vim.cmd("colorscheme rose-pine-main")
		vim.cmd("colorscheme rose-pine-moon")
		-- vim.cmd("colorscheme rose-pine-dawn")
	end,
}
Kanagawa = {
	"rebelot/kanagawa.nvim",
	dependencies = { "f-person/auto-dark-mode.nvim" },
	config = function()
		require("kanagawa").setup({
			theme = "wave",
			background = { dark = "wave", light = "lotus" },
			transparent = true,

			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},

			overrides = function(colors)
				local theme = colors.theme
				local makeDiagnosticColor = function(color)
					local c = require("kanagawa.lib.color")
					return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
				end
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- Save an hlgroup with dark background and dimmed foreground
					-- so that you can use it where your still want darker windows.
					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

					-- Match the completion menu to the editor background so it blends in like the hover float
					Pmenu = { fg = theme.ui.fg, bg = theme.ui.bg },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p1 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					-- Kanagawa hardcodes a blue (waveBlue) bg for the blink.cmp menu border,
					-- ignoring the Pmenu override above; match it to the menu background.
					BlinkCmpMenuBorder = { fg = theme.ui.fg_dim, bg = theme.ui.bg },

					-- Tint background of diagnostic messages
					DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
					DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
					DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
					DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
				}
			end,
		})
		vim.cmd("colorscheme kanagawa")

		require("auto-dark-mode").setup({
			set_dark_mode = function()
				vim.o.background = "dark"
				vim.cmd("colorscheme kanagawa")
			end,
			set_light_mode = function()
				vim.o.background = "light"
				vim.cmd("colorscheme kanagawa")
			end,
		})
	end,
}
return Kanagawa
