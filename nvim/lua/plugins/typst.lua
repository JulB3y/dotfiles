return {
  "typst-pkm",
  event = "VeryLazy",
  dir = "~/repos/typst-pkm/",
  config = function()
    require("typst-pkm").setup({
      root = "~/pkm",
    })
  end,
}
