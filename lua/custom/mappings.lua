local M = {}
-- All mappings for DAP are maintained in the dap.lua file
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
--    ["<leader>dr"] = {
--      "<cmd> DapContinue <CR>",
--      "Run or continue the debugger"
--    }
  },
}

return M
