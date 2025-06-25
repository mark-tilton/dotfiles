return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set("n", "<leader>b", ":Telescope file_browser<CR>", { desc = "[B]rowse Files" })
  end,
}
