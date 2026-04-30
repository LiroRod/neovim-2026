return {
  -- Tailwind CSS Tools - Enhanced features like sorting, concealing, colors
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    opts = {
      document_color = {
        enabled = true,
        kind = "inline",
        inline_symbol = "󰝤 ",
      },
      conceal = {
        enabled = false, -- Set to true if you want to hide Tailwind classes
        min_length = nil,
        symbol = "󱏿",
      },
      custom_filetypes = {},
    },
    keys = {
      { "<leader>ts", "<cmd>TailwindSort<cr>", desc = "Sort Tailwind classes" },
      { "<leader>tc", "<cmd>TailwindConcealToggle<cr>", desc = "Toggle Tailwind conceal" },
    },
  },

  -- Enhanced TypeScript tools with React support
  {
    "pmizio/typescript-tools.nvim",
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        tsserver_plugins = {
          -- React-specific TypeScript plugin
          "@styled/typescript-styled-plugin",
        },
      },
    },
  },

  -- Package info - Show package versions in package.json
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048",
          outdated = "#d19a66",
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
      })
    end,
    keys = {
      { "<leader>nu", function() require("package-info").update() end, desc = "Update package" },
      { "<leader>nd", function() require("package-info").delete() end, desc = "Delete package" },
      { "<leader>ni", function() require("package-info").install() end, desc = "Install package" },
      { "<leader>nc", function() require("package-info").change_version() end, desc = "Change package version" },
    },
  },

  -- Emmet for fast HTML/JSX writing
  {
    "olrtg/nvim-emmet",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    keys = {
      { "<leader>cw", function() require("nvim-emmet").wrap_with_abbreviation() end, mode = { "n", "v" }, desc = "Emmet Wrap" },
    },
  },

  -- React code snippets and utilities
  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    build = "npm install && npm run compile",
  },

  -- Better JSX/TSX indentation and folding
  {
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
  },

  -- Import cost - Show import size inline
  {
    "yardnsm/vim-import-cost",
    build = "npm install --production",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },

  -- Refactoring tools
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "go", "python", "lua" },
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          go = false,
          java = false,
          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        prompt_func_param_type = {
          go = false,
          java = false,
          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        printf_statements = {},
        print_var_statements = {},
      })
    end,
    keys = {
      {
        "<leader>re",
        function() require("refactoring").refactor("Extract Function") end,
        mode = "v",
        desc = "Extract Function",
      },
      {
        "<leader>rf",
        function() require("refactoring").refactor("Extract Function To File") end,
        mode = "v",
        desc = "Extract Function To File",
      },
      {
        "<leader>rv",
        function() require("refactoring").refactor("Extract Variable") end,
        mode = "v",
        desc = "Extract Variable",
      },
      {
        "<leader>ri",
        function() require("refactoring").refactor("Inline Variable") end,
        mode = { "n", "v" },
        desc = "Inline Variable",
      },
    },
  },

  -- ESLint integration
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
