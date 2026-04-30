return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  lazy = false,
  opts = {},
  keys = {
    {
      "<leader><space>",
      function() require("fff").find_files() end,
      desc = "Find Files (fff)",
    },
    {
      "<leader>/",
      function() require("fff").live_grep() end,
      desc = "Live Grep (fff)",
    },
    {
      "<leader>s/",
      function()
        require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
      end,
      desc = "Live Grep (fuzzy, fff)",
    },
    {
      "<leader>sw",
      function() require("fff").live_grep({ query = vim.fn.expand("<cword>") }) end,
      desc = "Search Word Under Cursor (fff)",
    },
  },
}
