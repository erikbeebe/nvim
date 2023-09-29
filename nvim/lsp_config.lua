require'lspconfig'.gopls.setup{
  cmd = {"/home/erik/go/bin/gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        composites = false,
      }
    }
  }
}

require'lspconfig'.clangd.setup{}

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
