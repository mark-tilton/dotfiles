-- Useful plugin to show you pending keybinds
return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    spec = {
      { "<leader>c", group = "[C]ode" },
      { "<leader>d", group = "[D]iagnostic" },
      { "<leader>D", group = "[D]ebug" },
      { "<leader>g", group = "[G]it" },
      { "<leader>h", group = "[H]arpoon / Git [H]unk" },
      { "<leader>r", group = "[R]ename" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>w", group = "[W]orkspace" },
    },
  },
}
