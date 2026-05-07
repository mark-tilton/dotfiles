return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    require("nvim-dap-virtual-text").setup()
    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- Helper: derive output binary path from cwd
    local function get_binary_path()
      local cwd = vim.fn.getcwd()
      local name = vim.fn.fnamemodify(cwd, ":t") -- folder name
      if vim.fn.has("win32") == 1 then
        return cwd .. "/" .. name .. ".exe"
      end
      return cwd .. "/" .. name
    end

    -- Helper: build the project, return true on success
    local function build_odin()
      vim.notify("Building Odin project...", vim.log.levels.INFO)
      local result = vim.fn.system({ "odin", "build", ".", "-debug" })
      if vim.v.shell_error ~= 0 then
        vim.notify("Build failed:\n" .. result, vim.log.levels.ERROR)
        return false
      end
      vim.notify("Build successful", vim.log.levels.INFO)
      return true
    end

    dap.configurations.odin = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          if not build_odin() then
            return dap.ABORT -- cancels the launch
          end
          return get_binary_path()
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- Keymaps
    vim.keymap.set("n", "<F5>", dap.continue)
    vim.keymap.set("n", "<S-F5>", dap.terminate)
    vim.keymap.set("n", "<F6>", dap.pause)
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
    vim.keymap.set("n", "<F12>", dap.step_out)

    -- Value hover: press K while debugging to inspect symbol under cursor
    vim.keymap.set({ "n", "v" }, "<Leader>k", function()
      require("dap.ui.widgets").hover(nil, { border = "rounded" })
    end)

    -- Set up inline hints
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = false, -- show value at every reference, not just first
      all_references = true,         -- annotate all references, not just declarations
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
      virt_text_pos = vim.fn.has('nvim-0.10') == 1 and 'inline' or 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    })
  end,
}
