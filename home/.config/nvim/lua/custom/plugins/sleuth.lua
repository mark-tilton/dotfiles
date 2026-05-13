return {
  "tpope/vim-sleuth",
  init = function()
    -- Markdown's list-continuation indents fool the heuristic; skip detection.
    vim.g.sleuth_markdown_heuristics = 0
  end,
}
