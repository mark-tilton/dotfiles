local ensure_installed = {
  "bash",
  "c",
  "c_sharp",
  "css",
  "diff",
  "dockerfile",
  "gitignore",
  "html",
  "javascript",
  "json",
  "json5",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "odin",
  "python",
  "query",
  "regex",
  "rust",
  "tmux",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

local function missing_parsers(treesitter)
  local installed = {}
  for _, lang in ipairs(treesitter.get_installed("parsers")) do
    installed[lang] = true
  end

  return vim.iter(ensure_installed)
    :filter(function(lang)
      return not installed[lang]
    end)
    :totable()
end

return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
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
  init = function()
    -- The main branch removed highlight/indent/ensure_installed config options.
    -- Highlighting and indentation must be enabled via FileType autocmd.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local ok = pcall(vim.treesitter.start)
        if ok then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
  config = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup()

    local missing = missing_parsers(treesitter)
    if #missing > 0 then
      treesitter.install(missing)
    end
  end,
}
