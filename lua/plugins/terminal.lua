-- Terminal plugins
return {
  -- Toggleterm for better terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>ft", "<cmd>ToggleTerm<cr>", desc = "Terminal (Root Dir)" },
      { "<leader>fT", function() require("toggleterm.terminal").Terminal:new({ dir = vim.uv.cwd() }):toggle() end, desc = "Terminal (cwd)" },
      { "<C-/>", "<cmd>ToggleTerm<cr>", desc = "Terminal (Root Dir)", mode = { "n", "t" } },
      { "<C-_>", "<cmd>ToggleTerm<cr>", desc = "which_key_ignore", mode = { "n", "t" } },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-/>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },
}
