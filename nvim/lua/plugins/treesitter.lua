return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master', -- nvim 0.11: der main-Branch braucht nvim >= 0.12
  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
              'typst', 'c', 'lua', 'markdown', 'markdown_inline'
            },
            sync_install = false,
            auto_install = false,
        }
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
  end,
}
