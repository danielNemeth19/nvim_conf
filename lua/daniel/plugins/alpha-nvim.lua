return {
    "goolord/alpha-nvim",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function ()
        local theta = require("alpha.themes.theta")
        theta.file_icons.provider = "devicons"
        require("alpha").setup(
            theta.config
        )
    end
}
