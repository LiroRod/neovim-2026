return {
	"ravitemer/mcphub.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local mcphub = require("mcphub")

		-- Setup MCP servers
		mcphub.setup({
			-- keep defaults first; add servers below
			servers = {
				-- BNP MCP Server (remote with streamable-http transport)
				bnp = {
					url = "https://bnp-mcp-server.grayplant-dc38eeff.brazilsouth.azurecontainerapps.io/mcp",
					transport = "streamable-http",
				},
				-- Local filesystem server (commented out, uncomment if needed)
				-- filesystem = {
				-- 	command = "npx",
				-- 	args = { "-y", "@modelcontextprotocol/server-filesystem", vim.fn.getcwd() },
				-- 	env = {},
				-- },
			},
		})

		-- Create user commands for easy access
		vim.api.nvim_create_user_command("MCPState", function()
			local state = mcphub.get_state()
			print(vim.inspect(state))
		end, { desc = "Show MCP Hub state" })

		vim.api.nvim_create_user_command("MCPListTools", function()
			local state = mcphub.get_state()
			if state and state.tools then
				print("Available MCP Tools:")
				for name, tool in pairs(state.tools) do
					print(string.format("  - %s: %s", name, tool.description or ""))
				end
			else
				print("No tools available or servers not initialized")
			end
		end, { desc = "List available MCP tools" })

		vim.api.nvim_create_user_command("MCPListResources", function()
			local state = mcphub.get_state()
			if state and state.resources then
				print("Available MCP Resources:")
				for _, resource in ipairs(state.resources) do
					print(string.format("  - %s: %s", resource.uri, resource.name or ""))
				end
			else
				print("No resources available or servers not initialized")
			end
		end, { desc = "List available MCP resources" })
	end,
	keys = {
		{
			"<leader>ms",
			"<cmd>MCPState<cr>",
			desc = "MCP State",
		},
		{
			"<leader>mt",
			"<cmd>MCPListTools<cr>",
			desc = "MCP List Tools",
		},
		{
			"<leader>mr",
			"<cmd>MCPListResources<cr>",
			desc = "MCP List Resources",
		},
	},
}
