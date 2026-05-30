return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    view_options = { show_hidden = true },
    -- Let C-h/C-l fall through to vim-tmux-navigator instead of oil's defaults
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
  },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
  },
}
