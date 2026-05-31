-- Picker + image rendering (replaces telescope, telescope-file-browser,
-- telescope-media-files, and image.nvim). Snacks.image renders via the kitty
-- graphics protocol, so the picker previews real images directly in Ghostty.
local image_filetypes = { "png", "jpg", "jpeg", "gif", "webp", "bmp", "pdf", "svg" }

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = { enabled = true },
    indent = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
    notifier = { enabled = true }, -- noice already prefers the snacks backend
    dashboard = { enabled = true },
    picker = {
      enabled = true,
      ui_select = true, -- replace vim.ui.select (also powers the yank history picker)
      sources = {
        files = { hidden = true, exclude = { "node_modules", ".git", ".venv" } },
        explorer = {
          hidden = true,
          -- Press \ again to close the explorer when it's focused
          win = { list = { keys = { ["\\"] = "close" } } },
        },
      },
    },
  },
  keys = {
    -- Search
    { "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
    { "<leader>ss", function() Snacks.picker.pickers() end, desc = "[S]earch [S]elect picker" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch current [W]ord", mode = { "n", "x" } },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
    { "<leader>s.", function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },
    { "<leader>sb", function() Snacks.picker.buffers() end, desc = "[S]earch existing [b]uffers" },
    { "<leader>sm", function() Snacks.picker.files({ ft = image_filetypes, title = "Media Files" }) end, desc = "[S]earch [M]edia" },
    { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },
    { "<leader><leader>", function() Snacks.picker.files() end, desc = "[ ] [ ] Search Files" },
    { "<leader>/", function() Snacks.picker.lines() end, desc = "[S]earch [/] in current buffer" },
    { "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "[S]earch [/] in Open Files" },

    -- Git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazy[g]it" },

    -- File browser
    { "<leader>b", function() Snacks.explorer() end, desc = "[B]rowse Files" },
    { "\\", function()
      -- Open+reveal (open grabs focus); if already open, jump focus into the tree.
      local open = Snacks.picker.get({ source = "explorer" })[1]
      Snacks.explorer.reveal()
      if open then open:focus("list") end
    end, desc = "Explorer (reveal / focus tree)" },
  },
}
