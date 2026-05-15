-- Zettelkasten note-taking via the `zk` CLI (https://github.com/zk-org/zk)
return {
  "zk-org/zk-nvim",
  ft = { "markdown" },
  keys = {
    { "<leader>z",  group = "[Z]k Notes" },
    { "<leader>zn", desc = "[Z]k [N]ew note" },
    { "<leader>zo", desc = "[Z]k [O]pen note" },
    { "<leader>zt", desc = "[Z]k [T]ags" },
    { "<leader>zb", desc = "[Z]k [B]acklinks" },
    { "<leader>zl", desc = "[Z]k [L]inks" },
    { "<leader>zg", desc = "[Z]k [G]rep" },
    { "<leader>zf", mode = "v", desc = "[Z]k [F]ind selection" },
  },
  config = function()
    require("zk").setup({
      picker = "telescope",
      lsp = {
        config = {
          cmd = { "zk", "lsp" },
          name = "zk",
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end,
          },
        },
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    })

    local zk = require("zk")
    local commands = require("zk.commands")

    vim.keymap.set("n", "<leader>zn", function()
      local title = vim.fn.input("Title: ")
      if title ~= "" then
        zk.new({ title = title })
      end
    end, { desc = "[Z]k [N]ew note" })

    vim.keymap.set("n", "<leader>zo", function()
      commands.get("ZkNotes")({ sort = { "modified" } })
    end, { desc = "[Z]k [O]pen note" })

    vim.keymap.set("n", "<leader>zt", "<Cmd>ZkTags<CR>", { desc = "[Z]k [T]ags" })
    vim.keymap.set("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", { desc = "[Z]k [B]acklinks" })
    vim.keymap.set("n", "<leader>zl", "<Cmd>ZkLinks<CR>", { desc = "[Z]k [L]inks" })

    vim.keymap.set("v", "<leader>zf", ":'<,'>ZkMatch<CR>", { desc = "[Z]k [F]ind selection" })

    -- Live-grep inside the notebook (zk-nvim doesn't ship this).
    vim.keymap.set("n", "<leader>zg", function()
      local dir = vim.env.ZK_NOTEBOOK_DIR
      if not dir or dir == "" then
        vim.notify("ZK_NOTEBOOK_DIR is not set", vim.log.levels.WARN)
        return
      end
      require("telescope.builtin").live_grep({ cwd = dir })
    end, { desc = "[Z]k [G]rep notes" })
  end,
}
