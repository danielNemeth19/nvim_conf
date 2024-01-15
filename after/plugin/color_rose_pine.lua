-- in real config it should only be one color config
function ColorMyPencils()
	require("rose-pine").setup({
		variant = 'auto',
		dim_inactive_windows = true,
		styles = {
			bold = false,
			italic = false,
			transparency = true
		}
	})
	vim.cmd.colorscheme("rose-pine")

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
