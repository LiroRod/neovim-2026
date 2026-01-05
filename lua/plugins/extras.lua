-- Extra utility plugins
return {
  -- LaTeX support
  {
    "lervag/vimtex",
    ft = { "tex", "latex" },
    config = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },

  -- Neorg for note-taking
  {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
      },
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Orgmode
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    opts = {
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    },
  },

  -- Nabla for LaTeX preview
  {
    "jbyuki/nabla.nvim",
    ft = { "markdown", "tex", "latex", "norg" },
    keys = {
      {
        "<leader>np",
        function()
          require("nabla").popup()
        end,
        desc = "Nabla Preview",
      },
    },
  },

  -- Magma for Jupyter notebooks
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    ft = { "python", "jupyter" },
    cmd = { "MagmaEvaluateLine", "MagmaEvaluateVisual" },
    init = function()
      vim.g.magma_automatically_open_output = false
    end,
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  -- Session manager
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- Motion plugins
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap Forward" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap Backward" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    },
    config = function()
      local leap = require("leap")
      -- Set up keymaps manually since add_default_mappings is deprecated
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
    end,
  },

  {
    "ggandor/flit.nvim",
    event = "VeryLazy",
    dependencies = { "leap.nvim" },
    opts = {
      labeled_modes = "nv",
    },
  },

  -- Flash for enhanced motion (disabled in favor of leap.nvim)
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- },

  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon Add File" },
      { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Menu" },
      { "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Harpoon File 1" },
      { "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Harpoon File 2" },
      { "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Harpoon File 3" },
      { "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Harpoon File 4" },
    },
    opts = {},
  },

  -- Spectre for search and replace
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
    },
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
  },

  -- Better matchparen
  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {},
    init = function()
      vim.g.loaded_matchparen = 1
    end,
  },

  -- Hydra for submode menus (like in nyoom.nvim)
  {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
  },

  -- Mini.nvim collection
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- Better around/inside textobjects (already configured in coding.lua)
      -- require('mini.ai').setup()

      -- Add/delete/replace surroundings (already configured in coding.lua)
      -- require('mini.surround').setup()

      -- Simple and easy statusline (we use lualine instead)
      -- require('mini.statusline').setup()

      -- Move lines
      require("mini.move").setup()
    end,
  },
}
