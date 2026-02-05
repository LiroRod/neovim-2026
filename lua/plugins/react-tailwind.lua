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

  -- Tailwind colorizer for completion menu
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })

      -- Integrate with nvim-cmp
      local ok, cmp = pcall(require, "cmp")
      if ok then
        local format = require("tailwindcss-colorizer-cmp").formatter
        local original_formatting = cmp.get_config().formatting or {}
        local original_format = original_formatting.format

        cmp.setup({
          formatting = {
            format = function(entry, item)
              if original_format then
                item = original_format(entry, item)
              end
              return format(entry, item)
            end,
          },
        })
      end
    end,
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
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>e", require("nvim-emmet").wrap_with_abbreviation, { desc = "Emmet wrap" })
    end,
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

  -- Conform for formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        scss = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        jsonc = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        graphql = { { "prettierd", "prettier" } },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    },
    init = function()
      -- Command to toggle format on save
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          -- Toggle for current buffer
          vim.b.disable_autoformat = not vim.b.disable_autoformat
        else
          -- Toggle globally
          vim.g.disable_autoformat = not vim.g.disable_autoformat
        end
      end, {
        desc = "Toggle autoformat on save",
        bang = true,
      })
    end,
  },
}
