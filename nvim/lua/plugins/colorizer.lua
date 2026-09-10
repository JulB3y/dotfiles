return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },
  opts = { "css", "javascript", "typescript", "html", "lua" },
  config = function(_, opts)
    require("colorizer").setup({
      filetypes = opts,
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or red
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features
        css_fn = true, -- Enable all CSS functions
        mode = "background", -- Display mode: "background" | "foreground" | "virtualtext"
        tailwind = true, -- Enable Tailwind CSS color preview
        sass = { enable = true, parsers = { "css" } },
        virtualtext = "■",
      },
    })
  end,
}
