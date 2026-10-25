return {
  dir = "~/repos/math-conceal", -- lokaler Typst-only Fork von pxwg/math-conceal.nvim
  event = "VeryLazy",
  main = "math-conceal",
  build = "cargo build --release --manifest-path service/Cargo.toml", -- required for graphical equation conceal
  --- @type MathConcealOptions
  opts = {
    conceal = {
      "greek",
      "script",
      "math",
      "font",
      "delim",
      "phy",
    },
    ft = { "markdown", "typst" },
    opt = {
      conceallevel = 2,
      concealcursor = "n",
    },
    image = {
      enabled = true, -- graphical equation conceal via kitty graphics protocol
    },
  },
}
