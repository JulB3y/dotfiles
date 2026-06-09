return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
        require('nvim-treesitter').install {
            'typst', 'c', 'lua'
        }
  end,
}
