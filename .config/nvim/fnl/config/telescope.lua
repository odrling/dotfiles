require('telescope').setup {
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden" }
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      }
    }
  }
}

require("telescope").load_extension("zf-native")
require('telescope').load_extension("ui-select")
