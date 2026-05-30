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
    { "<leader>zv", desc = "[Z]k Graph [V]iew" },
    { "<leader>zf", mode = "v", desc = "[Z]k [F]ind selection" },
  },
  config = function()
    require("zk").setup({
      picker = "snacks_picker",
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

    vim.keymap.set("n", "<leader>zv", function()
      if vim.fn.executable("zk-graph-view") == 0 then
        vim.notify("zk-graph-view is not installed", vim.log.levels.WARN)
        return
      end

      local dir = vim.env.ZK_NOTEBOOK_DIR
      if not dir or dir == "" then
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file ~= "" then
          dir = vim.fn.fnamemodify(current_file, ":p:h")
        else
          dir = vim.fn.getcwd()
        end
      end

      local cache_dir = vim.fn.stdpath("cache")
      vim.fn.mkdir(cache_dir, "p")
      local output = cache_dir .. "/zk-graph-view.html"

      local stderr = {}
      local job_id = vim.fn.jobstart({ "zk-graph-view", "--output", output }, {
        cwd = dir,
        stderr_buffered = true,
        on_stderr = function(_, data)
          stderr = data
        end,
        on_exit = function(_, code)
          if code == 0 then
            vim.notify("Opened zk graph view", vim.log.levels.INFO)
          else
            local message = table.concat(stderr or {}, "\n")
            if message == "" then
              message = "zk-graph-view failed"
            end
            vim.notify(message, vim.log.levels.ERROR)
          end
        end,
      })

      if job_id <= 0 then
        vim.notify("Failed to start zk-graph-view", vim.log.levels.ERROR)
      end
    end, { desc = "[Z]k Graph [V]iew" })

    vim.keymap.set("v", "<leader>zf", ":'<,'>ZkMatch<CR>", { desc = "[Z]k [F]ind selection" })

    -- Live-grep inside the notebook (zk-nvim doesn't ship this).
    vim.keymap.set("n", "<leader>zg", function()
      local dir = vim.env.ZK_NOTEBOOK_DIR
      if not dir or dir == "" then
        vim.notify("ZK_NOTEBOOK_DIR is not set", vim.log.levels.WARN)
        return
      end
      Snacks.picker.grep({ dirs = { dir } })
    end, { desc = "[Z]k [G]rep notes" })
  end,
}
