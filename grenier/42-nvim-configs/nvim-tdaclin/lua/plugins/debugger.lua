return {

	{
		enabled = false,
		"https://github.com/mfussenegger/nvim-dap", version = "0.8.*",
		config = function()
			require("dap").adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode-12",
			}
			require("dap").configurations.c = {
				{
					name = "Launch using lldb",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false, -- TODO: stop on main
					args = {},
					runInTerminal = false, -- TODO: maybe change to true
					-- see https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
				}
			}
		end,
		keys = function()
			local dap = require("dap")
			return {
				{ "<leader>dc", dap.continue, "Dap Continue" },
				{ "<leader>dn", dap.step_over, "Dap Step Over" },
				{ "<leader>ds", dap.step_into, "Dap Step Into" },
				{ "<leader>df", dap.step_out, "Dap Step Out" },
				{ "<leader>dl", dap.step_over, "Dap Step Over" },
				{ "<leader>dj", dap.step_into, "Dap Step Into" },
				{ "<leader>dk", dap.step_out, "Dap Step Out" },
				{ "<leader>db", dap.toggle_breakpoint, "Dap Toggle Breakpoint" },
				{ "<leader>dr", dap.repl.toggle, "Dap Toggle Repl" },
				{ "<leader>dt", dap.run_to_cursor, "Dap Run to Cursor" },
				{ "<leader>dq", dap.terminate, "Dap Terminate" },
			}
		end,
	},
	
	{
		enabled = false,
		"rcarriga/nvim-dap-ui", version = "4.*",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		opts = {
			layouts = {
				{
					elements = {
						"consol",
						"repl",
						"scopes",
					},
					position = "bottom",
					size = 10,
				},
			},

		},
		config = function(plugin, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.before.attach.dapui_config = dapui.open
			dap.listeners.before.launch.dapui_config = dapui.open
			dap.listeners.before.event_terminated.dapui_config = dapui.close
			dap.listeners.before.event_exited.dapui_config = dapui.close
		end,
		keys = function()
			local dapui = require("dapui")
			return {
				{ "<leader>de", dapui.eval, "Dapui Eval" },
			}
		end,
	},

}
