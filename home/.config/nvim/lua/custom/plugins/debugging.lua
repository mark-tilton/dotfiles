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

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })

    local sign = vim.fn.sign_define
    sign("DapBreakpoint",          { text = "●", texthl = "DapBreakpoint",          linehl = "",               numhl = "" })
    sign("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "",               numhl = "" })
    sign("DapLogPoint",            { text = "◆", texthl = "DapLogPoint",            linehl = "",               numhl = "" })
    sign("DapStopped",             { text = "▶", texthl = "DapStopped",             linehl = "DapStoppedLine", numhl = "" })
    sign("DapBreakpointRejected",  { text = "", texthl = "DapBreakpointRejected",  linehl = "",               numhl = "" })

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

    -- Helper: resolve the output binary path.
    -- A project's `.nvim.lua` can set `vim.g.odin_debug_program` (absolute, or
    -- relative to cwd). Otherwise fall back to deriving it from the folder name.
    local function get_binary_path()
      local cwd = vim.fn.getcwd()
      local program = vim.g.odin_debug_program
      if program ~= nil and program ~= "" then
        if program:sub(1, 1) ~= "/" then
          program = cwd .. "/" .. program
        end
        return program
      end
      local name = vim.fn.fnamemodify(cwd, ":t") -- folder name
      if vim.fn.has("win32") == 1 then
        return cwd .. "/" .. name .. ".exe"
      end
      return cwd .. "/" .. name
    end

    -- Helper: build the project, return true on success.
    -- A project's `.nvim.lua` can set `vim.g.odin_debug_build` (a string run via
    -- the shell, e.g. "./build.sh", or a list of argv). Otherwise default to a
    -- plain debug build in the cwd.
    local function build_odin()
      local cmd = vim.g.odin_debug_build
      if cmd == nil or cmd == "" then
        cmd = { "odin", "build", ".", "-debug" }
      end
      vim.notify("Building Odin project...", vim.log.levels.INFO)
      local result = vim.fn.system(cmd)
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
        args = function()
          return vim.g.odin_debug_args or {}
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- Keymaps
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<leader>Dt", dap.terminate, { desc = "Debug: [T]erminate" })
    vim.keymap.set("n", "<F6>", dap.pause, { desc = "Debug: Pause" })
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })

    -- Value hover: press K while debugging to inspect symbol under cursor
    vim.keymap.set({ "n", "v" }, "<Leader>k", function()
      require("dap.ui.widgets").hover(nil, { border = "rounded" })
    end, { desc = "Debug: Hover value" })

    -- Add the word under cursor to the watches panel
    vim.keymap.set("n", "<leader>Dw", function()
      require("dapui").elements.watches.add(vim.fn.expand("<cword>"))
    end, { desc = "Debug: [W]atch word under cursor" })

    -- Add visual selection to the watches panel
    vim.keymap.set("v", "<leader>Dw", function()
      local s = vim.fn.getpos("'<")
      local e = vim.fn.getpos("'>")
      local lines = vim.fn.getline(s[2], e[2])
      if #lines == 0 then return end
      lines[#lines] = string.sub(lines[#lines], 1, e[3])
      lines[1] = string.sub(lines[1], s[3])
      require("dapui").elements.watches.add(table.concat(lines, "\n"))
    end, { desc = "Debug: [W]atch selection" })

    -- Eval expression in a focusable popup (press q to close, e to expand)
    vim.keymap.set({ "n", "v" }, "<leader>De", function()
      require("dapui").eval(nil, { enter = true })
    end, { desc = "Debug: [E]val expression" })

    -- Close DAP floating windows with q or <Esc>
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-float",
      callback = function(args)
        vim.keymap.set("n", "q", "<cmd>close!<cr>", { buffer = args.buf, silent = true })
        vim.keymap.set("n", "<Esc>", "<cmd>close!<cr>", { buffer = args.buf, silent = true })
      end,
    })

    -- Set up inline hints
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true, -- show value at every reference, not just first
      all_references = true,        -- annotate all references, not just declarations
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
