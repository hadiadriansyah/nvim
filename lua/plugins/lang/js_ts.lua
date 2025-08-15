return {
	{
		"neovim/nvim-lspconfig",
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "html", "css" },
		config = function()
			local lspconfig = require("lspconfig")
			local caps = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = require("utils.lsp_on_attach")

			-- tsserver
			lspconfig.tsserver.setup({
				capabilities = caps,
				on_attach = function(client, bufnr)
					-- format via prettier/conform, nonaktif format tsserver
					client.server_capabilities.documentFormattingProvider = false
					on_attach(client, bufnr)
				end,
			})

			-- eslint
			lspconfig.eslint.setup({
				capabilities = caps,
				on_attach = function(_, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			-- tailwindcss, html, css handled di lsp.lua
		end,
	},
	-- JS/TS Debug (Node, Next, RN)
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		config = function()
			require("dap-vscode-js").setup({
				adapters = { "pwa-node", "pwa-chrome", "node-terminal", "pwa-extensionHost" },
			})
			local dap = require("dap")
			for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[lang] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}
