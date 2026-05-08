return {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  opts = {
    ring = { storage = "shada" },
  },
  keys = {
    { "<leader>p", function() require("telescope").extensions.yank_history.yank_history() end, desc = "Yank History" },
    { "y",         "<Plug>(YankyYank)",                                                        mode = { "n", "x" },                                desc = "Yank text" },
    { "p",         "<Plug>(YankyPutAfter)",                                                    mode = { "n", "x" },                                desc = "Put after" },
    { "P",         "<Plug>(YankyPutBefore)",                                                   mode = { "n", "x" },                                desc = "Put before" },
    { "gp",        "<Plug>(YankyGPutAfter)",                                                   mode = { "n", "x" },                                desc = "Put after (cursor moves)" },
    { "gP",        "<Plug>(YankyGPutBefore)",                                                  mode = { "n", "x" },                                desc = "Put before (cursor moves)" },
    { "]p",        "<Plug>(YankyCycleForward)",                                                desc = "Cycle forward through yank ring" },
    { "[p",        "<Plug>(YankyCycleBackward)",                                               desc = "Cycle backward through yank ring" },
  },
}
