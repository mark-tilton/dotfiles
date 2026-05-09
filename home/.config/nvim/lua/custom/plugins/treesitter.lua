return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      init = function()
        vim.g.no_plugin_maps = true
      end,
      config = function()
        require("nvim-treesitter-textobjects").setup({
          select = {
            lookahead = true,
          },
          move = {
            set_jumps = true,
          },
        })

        local select = require("nvim-treesitter-textobjects.select")
        local move = require("nvim-treesitter-textobjects.move")
        local swap = require("nvim-treesitter-textobjects.swap")
        local repeatable = require("nvim-treesitter-textobjects.repeatable_move")

        local select_map = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        }
        for lhs, query in pairs(select_map) do
          vim.keymap.set({ "x", "o" }, lhs, function()
            select.select_textobject(query, "textobjects")
          end, { desc = "Select " .. query })
        end

        local next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.inner",
        }
        local prev_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.inner",
        }
        for lhs, query in pairs(next_start) do
          local fn = repeatable.make_repeatable_move(function()
            move.goto_next_start(query, "textobjects")
          end)
          vim.keymap.set({ "n", "x", "o" }, lhs, fn, { desc = "Next " .. query .. " start" })
        end
        for lhs, query in pairs(prev_start) do
          local fn = repeatable.make_repeatable_move(function()
            move.goto_previous_start(query, "textobjects")
          end)
          vim.keymap.set({ "n", "x", "o" }, lhs, fn, { desc = "Prev " .. query .. " start" })
        end

        vim.keymap.set({ "n", "x", "o" }, ";", repeatable.repeat_last_move, { desc = "Repeat last move" })
        vim.keymap.set({ "n", "x", "o" }, ",", repeatable.repeat_last_move_opposite, { desc = "Repeat last move opposite" })
        vim.keymap.set({ "n", "x", "o" }, "f", repeatable.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", repeatable.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", repeatable.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", repeatable.builtin_T_expr, { expr = true })

        vim.keymap.set("n", "<leader>na", function()
          swap.swap_next("@parameter.inner", "textobjects")
        end, { desc = "Swap next parameter" })
        vim.keymap.set("n", "<leader>nf", function()
          swap.swap_next("@function.outer", "textobjects")
        end, { desc = "Swap next function" })
        vim.keymap.set("n", "<leader>pa", function()
          swap.swap_previous("@parameter.inner", "textobjects")
        end, { desc = "Swap prev parameter" })
        vim.keymap.set("n", "<leader>pf", function()
          swap.swap_previous("@function.outer", "textobjects")
        end, { desc = "Swap prev function" })
      end,
    },
  },
  opts = {
    ensure_installed = { "bash", "c", "diff", "html", "json5", "odin", "lua", "luadoc", "markdown", "vim", "vimdoc" },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
  },
  config = function(_, opts)
    require("nvim-treesitter.install").prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup(opts)
  end,
}
