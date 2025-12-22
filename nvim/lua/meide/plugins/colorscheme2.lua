return {
  "ramojus/mellifluous.nvim",
  -- only requird if using nvim-web-devicons for icons
  -- dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
  config = function()
        require("mellifluous").setup({        color_overrides = {
                dark = {
                    colors = function(colors)
                        return {
                            main_keywords = "#e0412f",
                            other_keywords = "#b14539",
                            functions = "#90423c",
                            types = "#58575e",
                            constants = "#8f736d",
                        }
                    end
                }
            }
        })
    end,
}
