local actions = require("telescope.actions")
require('telescope').setup{
  defaults = {
    sorting_strategy = "ascending",
    mappings = {
          n = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
          }, -- n
          i = {
            ["<C-h>"] = "which_key",
            ['<c-d>'] = require('telescope.actions').delete_buffer,
          } -- i
        }, --mappings
  },
  pickers = {
    find_files = {
      hidden = true,
      path_display = { "truncate" }
    }
  }
}
