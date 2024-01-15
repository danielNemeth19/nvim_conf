-- in real config it should only be one color config
function ColorMyPencils()
	require("kanagawa").setup({
		transparent=true,
		undercurl=true,
		terminalColors=true,
		commentStyle= { italic=true },
		background = {
			dark = "dragon"
		},
		overrides = function(colors)
			local theme = colors.theme
			return {
				NormalFloat = {bg = "none"},
				FloatBorder = {bg = "none"},
				FloatTitle = {bg = "none"},
				NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
				LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				String = {fg = colors.palette.carpYellow, italic = false }
			}
		end,
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none"
					}
				}
			}
		}
	})
	vim.cmd.colorscheme("kanagawa")

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
