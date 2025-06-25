-- Useful plugin to show you pending keybinds
return {
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup({
      -- Document existing key chains
      mappings = {
        { "", group = "[T]oggle" },
        { "", group = "[C]ode" },
        { "", group = "[W]orkspace" },
        { "", group = "[R]ename" },
        { "", group = "[D]ocument" },
        { "", group = "[S]earch" },
        { "", group = "Git [H]unk" },
        { "", desc = "",            hidden = true, mode = { "n", "n", "n", "n", "n", "n", "n" } },
        { "", desc = "",            mode = "v" },
      },
    })
  end,
}
