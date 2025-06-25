Gruvbox = {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  opts = {
    transparent_mode = true,
  },
  init = function()
    vim.cmd.colorscheme("gruvbox")
    vim.cmd.hi("Comment gui=none")
  end,
}
TokyoNight = {
  "folke/tokyonight.nvim",
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    }
  },
  init = function()
    vim.cmd.colorscheme("tokyonight")
    vim.cmd.hi("Comment gui=none")
  end,
}
RosePine = {
  "rose-pine/neovim",
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "moon",      -- auto, main, moon, or dawn
      dark_variant = "moon", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true,        -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },

      highlight_groups = {
        NormalFloat = { bg = "none" },
      },
    })

    vim.cmd("colorscheme rose-pine-moon")
  end,
}
return RosePine
