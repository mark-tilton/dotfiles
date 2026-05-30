return {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  opts = {
    ring = { storage = "shada" },
  },
  keys = {
    { "<leader>p", function()
      -- Yanky has no snacks picker integration, so drive it through vim.ui.select
      -- (rendered by Snacks picker via ui_select).
      local history = require("yanky.history").all()
      if vim.tbl_isempty(history) then
        vim.notify("Yank history is empty")
        return
      end
      vim.ui.select(history, {
        prompt = "Yank History",
        format_item = function(item)
          local text = type(item.regcontents) == "table"
            and table.concat(item.regcontents, "\\n") or tostring(item.regcontents)
          return (text:gsub("%s+", " "))
        end,
      }, function(choice)
        if not choice then return end
        vim.fn.setreg('"', choice.regcontents, choice.regtype)
        vim.api.nvim_feedkeys("p", "n", false)
      end)
    end, desc = "Yank History" },
    { "y",         "<Plug>(YankyYank)",                                                        mode = { "n", "x" },                                desc = "Yank text" },
    { "p",         "<Plug>(YankyPutAfter)",                                                    mode = { "n", "x" },                                desc = "Put after" },
    { "P",         "<Plug>(YankyPutBefore)",                                                   mode = { "n", "x" },                                desc = "Put before" },
    { "gp",        "<Plug>(YankyGPutAfter)",                                                   mode = { "n", "x" },                                desc = "Put after (cursor moves)" },
    { "gP",        "<Plug>(YankyGPutBefore)",                                                  mode = { "n", "x" },                                desc = "Put before (cursor moves)" },
    { "]p",        "<Plug>(YankyCycleForward)",                                                desc = "Cycle forward through yank ring" },
    { "[p",        "<Plug>(YankyCycleBackward)",                                               desc = "Cycle backward through yank ring" },
  },
}
