return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	ft = "markdown",
	cmd = { "Obsidian" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "liros-vault",
				path = "/Users/murilorodrigues/Library/Mobile Documents/iCloud~md~obsidian/documents/liros-vault",
			},
		},
		completion = {
			blink = true,
			min_chars = 2,
		},
		picker = {
			name = "telescope.nvim",
		},
		ui = {
			enable = false,
		},
		templates = {
			folder = "Templates",
		},
		attachments = {
			img_folder = "Assets",
		},
	},
	keys = {
		{ "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
		{ "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Note" },
		{ "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search" },
		{ "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename" },
		{ "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "Workspace" },
		{ "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Today" },
		{ "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday" },
		{ "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Dailies" },
		{ "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
		{ "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Links" },
		{ "<leader>o#", "<cmd>Obsidian tags<cr>", desc = "Tags" },
		{ "<leader>ox", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle Checkbox" },
		{ "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Paste Image" },
	},
}
