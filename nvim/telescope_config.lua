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
            ["<CR>"] = "select_tab"
          } -- i
        }, --mappings
  },
  pickers = {
    find_files = {
      hidden = true,
      mappings = {
        i = { ["<CR>"] = actions.select_tab_drop }
      }
    },
    buffers = {
      mappings = {
        i = { ["<CR>"] = actions.select_tab_drop }
      }
    },
    git_files = {
      mappings = {
        i = { ["<CR>"] = actions.select_tab_drop }
      }
    },
    old_files = {
      mappings = {
        i = { ["<CR>"] = actions.select_tab_drop }
      }
    }
  }
}
