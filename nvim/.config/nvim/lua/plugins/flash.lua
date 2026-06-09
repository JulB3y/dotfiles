return {
  "folke/flash.nvim",
  ---@type Flash.Config
 event = { "BufReadPre", "BufNewFile" },
  opts = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}
