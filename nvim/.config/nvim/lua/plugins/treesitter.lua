return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
        require('nvim-treesitter').install {
            'typst', 'c', 'lua'
        }
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
  end,
}
