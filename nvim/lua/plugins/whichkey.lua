return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "gf",
      desc = "Open file/link under cursor",
      function()
        -- Inside an Obsidian vault (its LSP is attached) follow wiki/markdown links,
        -- otherwise fall back to the built-in gf.
        if #vim.lsp.get_clients({ name = "obsidian-ls", bufnr = 0 }) > 0 then
          vim.cmd("Obsidian follow_link")
        else
          vim.cmd.normal({ "gf", bang = true })
        end
      end,
    },
  },
}
