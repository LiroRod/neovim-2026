vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.fillchars = { eob = " " }
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.confirm = true
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = "menu,menuone,noselect"
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.grepprg = "rg --vimgrep --smart-case"
opt.grepformat = "%f:%l:%c:%m"
opt.path:append("**")

vim.filetype.add({ extension = { h = "c" } })

local map = vim.keymap.set
local function grep_prompt()
	vim.cmd.copen()
	vim.ui.input({ prompt = "rg: " }, function(input)
		if input and input ~= "" then
			vim.cmd.grep(vim.fn.fnameescape(input))
			vim.cmd.copen()
		end
	end)
end

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search" })
map("n", "<leader>g", grep_prompt, { desc = "Ripgrep to quickfix" })
map("n", "[q", "<cmd>cprevious<cr>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
map({ "n", "x" }, "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Debug continue" })
map("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Debug step into" })
map("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "Debug step over" })
map("n", "<leader>dO", function()
	require("dap").step_out()
end, { desc = "Debug step out" })
map("n", "<leader>dr", function()
	require("dap").repl.toggle()
end, { desc = "Debug REPL" })
map("n", "<leader>dt", function()
	require("dap").terminate()
end, { desc = "Debug terminate" })
map("n", "<leader>dl", function()
	require("osv").launch({ port = 8086 })
end, { desc = "Debug Lua server" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Terminal normal mode" })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "rust" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

vim.diagnostic.config({
	virtual_text = { spacing = 3, prefix = "●" },
	float = { border = "rounded", source = true },
	severity_sort = true,
	signs = true,
})

require("lazy").setup({
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.background = "dark"
			vim.cmd.colorscheme("oxocarbon")

			for _, group in ipairs({
				"Normal",
				"NormalNC",
				"NormalFloat",
				"FloatBorder",
				"SignColumn",
				"LineNr",
				"EndOfBuffer",
				"NeoTreeNormal",
				"NeoTreeNormalNC",
				"NeoTreeEndOfBuffer",
			}) do
				vim.api.nvim_set_hl(0, group, { bg = "none" })
			end
		end,
	},
	require("plugins.snacks"),
	require("plugins.fff"),
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			spec = { { "<leader>d", group = "debug" } },
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer keymaps",
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Toggle sidebar",
			},
			{
				"<leader>E",
				function()
					require("neo-tree.command").execute({ reveal = true })
				end,
				desc = "Reveal current file",
			},
			{
				"<leader>be",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer sidebar",
			},
			{
				"<leader>ge",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git sidebar",
			},
		},
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "qf", "starter" },
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			window = {
				width = 34,
				mappings = {
					["<space>"] = "none",
					["Y"] = function(state)
						local node = state.tree:get_node()
						vim.fn.setreg("+", node:get_id(), "c")
					end,
				},
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = {
			override = {
				zsh = {
					icon = "",
					color = "#428850",
					cterm_color = "65",
					name = "Zsh",
				},
			},
		},
	},
	{
		"MunifTanjim/nui.nvim",
		lazy = true,
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = function()
			local treesitter = require("nvim-treesitter")
			local wanted = { "c", "cpp", "lua", "luadoc", "rust", "toml", "vim", "vimdoc" }
			local available = {}
			for _, parser in ipairs(treesitter.get_available()) do
				available[parser] = true
			end

			local parsers = vim.tbl_filter(function(parser)
				return available[parser]
			end, wanted)

			treesitter.install(parsers, { summary = true }):wait(300000)
		end,
		lazy = false,
		config = function()
			require("nvim-treesitter").setup()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = { "clangd", "lua_ls", "rust_analyzer" },
			automatic_enable = false,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = { ensure_installed = { "clang-format", "codelldb", "stylua" } },
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			keymap = { preset = "default" },
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				ghost_text = { enabled = true },
			},
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			fast_wrap = {},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			require("lspconfig")

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
							completion = { callSnippet = "Replace" },
						},
					},
				},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--completion-style=detailed",
						"--header-insertion=iwyu",
						"--fallback-style=llvm",
					},
				},
				rust_analyzer = {
					root_dir = function(bufnr, on_dir)
						on_dir(vim.fs.root(bufnr, { "Cargo.toml", "rust-project.json", ".git" }) or vim.fn.getcwd())
					end,
					settings = {
						["rust-analyzer"] = {
							check = { command = "clippy" },
							cargo = { allFeatures = true },
							inlayHints = { lifetimeElisionHints = { enable = "always" } },
						},
					},
				},
			}

			for name, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(name, config)
				vim.lsp.enable(name)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
					map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
					map("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }))
					map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
					map("n", "<leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
					map("n", "<leader>a", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				rust = { "rustfmt" },
			},
			format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = { "jbyuki/one-small-step-for-vimkind" },
		config = function()
			local dap = require("dap")
			local codelldb = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb,
					args = { "--port", "${port}" },
				},
			}

			local function executable()
				return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
			end

			local function args()
				local input = vim.fn.input("Args: ")
				return input == "" and {} or vim.split(input, " ")
			end

			local native = {
				{
					name = "Launch executable",
					type = "codelldb",
					request = "launch",
					program = executable,
					args = args,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = native
			dap.configurations.cpp = native
			dap.configurations.rust = native

			dap.adapters.nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end
			dap.configurations.lua = {
				{
					name = "Attach to running Neovim",
					type = "nlua",
					request = "attach",
					host = "127.0.0.1",
					port = 8086,
				},
			}
		end,
	},
}, {
	install = { missing = true },
	checker = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
