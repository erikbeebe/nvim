-- bufferline
vim.opt.termguicolors = true

local bufferline = require("bufferline")
bufferline.setup{
  options = {
    diagnostics = "nvim_lsp",
    style_preset = {
        bufferline.style_preset.no_italic,
        bufferline.style_preset.no_bold
    }
  }
}
