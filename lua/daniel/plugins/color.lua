-- return {
-- 'rebelot/kanagawa.nvim',
-- priority = 1000,
-- config = function()
-- require("kanagawa").setup({
-- transparent = true,
-- undercurl = true,
-- terminalColors = true,
-- commentStyle = { italic = true },
-- keywordStyle = { bold = true },
-- background = {
-- dark = "dragon"
-- },
-- overrides = function(colors)
-- local theme = colors.theme
-- return {
-- NormalFloat = { bg = "none" },
-- FloatBorder = { bg = "none" },
-- FloatTitle = { bg = "none" },
-- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
-- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
-- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
-- String = { fg = colors.palette.carpYellow, italic = false }
-- }
-- end,
-- colors = {
-- theme = {
-- all = {
-- ui = {
-- bg_gutter = "none"
-- }
-- }
-- }
-- }
-- })
-- vim.cmd.colorscheme("kanagawa")

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end
-- }
-- return {
-- "folke/tokyonight.nvim",
-- priority = 1000,
-- init = function ()
-- vim.cmd.colorscheme('tokyonight-night')
-- end
-- }
return {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    opts = {
        styles = {
            transparency = true,
        },
    },
    config = function(_, opts)
        require('rose-pine').setup(opts)
        vim.cmd('colorscheme rose-pine')
    end
}
