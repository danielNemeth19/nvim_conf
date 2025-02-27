return {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local theta = require("alpha.themes.theta")
        local dashboard = require("alpha.themes.dashboard")
        theta.file_icons.provider = "devicons"
        theta.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
        }
        theta.buttons.val = {
            { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
            { type = "padding", val = 1 },
            dashboard.button("e", "  New file", "<cmd>ene<CR>"),
            dashboard.button("leader ff", "󰈞  Find file", "<leader>ff"),
            dashboard.button("leader nc", "  Configuration", "<leader>nc"),
            dashboard.button("leader ps", "󰈞  Live grep", "<leader>ps"),
            dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
        },
        require("alpha").setup(
            theta.config
        )
    end
}
