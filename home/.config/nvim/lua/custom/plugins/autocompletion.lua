-- Autocompletion
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "1.*", -- use the prebuilt release binary (no rust toolchain needed)
  dependencies = {
    "folke/lazydev.nvim",
  },
  opts = {
    -- See `:help blink-cmp-config-keymap`. Ported from the old nvim-cmp maps.
    keymap = {
      preset = "none",
      ["<C-e>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "select_prev", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      -- Jump through LSP snippet placeholders (e.g. function arguments).
      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },
    },

    completion = {
      list = { selection = { preselect = true, auto_insert = false } },
      menu = { border = "rounded" },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
      ghost_text = { enabled = true },
    },

    sources = {
      default = { "lsp", "path", "lazydev" },
      per_filetype = { markdown = { "lsp", "path" } },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show lazydev completions above LSP
        },
      },
    },
  },
}
