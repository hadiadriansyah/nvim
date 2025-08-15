-- plugins/lspsaga.lua
return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- icons
			"nvim-treesitter/nvim-treesitter", -- better UI/preview
		},
		opts = {
			-- Keep UI lean but nice
			ui = { border = "rounded", title = true },
			lightbulb = { enable = true },
			symbol_in_winbar = { enable = false },
			code_action = { extend_gitsigns = true },
			outline = { layout = "float", win_width = 40 },
		},
		config = function(_, opts)
			require("lspsaga").setup(opts)

			-- Create buffer-local keymaps only when an LSP attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspsagaKeymaps", { clear = true }),
				callback = function(ev)
					local buf = ev.buf
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true, noremap = true })
					end

					--------------------------------------------------------------------
					-- Peek / Finder (VSCode-like)
					--------------------------------------------------------------------
					map("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", "Peek definition")
					map("n", "<leader>pt", "<cmd>Lspsaga peek_type_definition<CR>", "Peek type definition")
					map("n", "<leader>pf", "<cmd>Lspsaga finder<CR>", "Finder (def/impl/refs)")

					--------------------------------------------------------------------
					-- Hover & Signature
					--------------------------------------------------------------------
					map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover docs (Saga)")
					map({ "n", "i" }, "<C-k>", "<cmd>Lspsaga signature_help<CR>", "Signature help")

					--------------------------------------------------------------------
					-- Code Action & Rename
					--------------------------------------------------------------------
					map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code action")
					map("x", "<leader>ca", "<cmd><C-U>Lspsaga code_action<CR>", "Code action (range)")
					map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Rename symbol")

					--------------------------------------------------------------------
					-- Diagnostics (show / jump)
					--------------------------------------------------------------------
					map("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics")
					map("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostics")
					map("n", "<leader>db", "<cmd>Lspsaga show_buf_diagnostics<CR>", "Show buffer diagnostics")
					map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev diagnostic")
					map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic")

					-- Jump only ERRORs (optional)
					map("n", "[e", function()
						require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
					end, "Prev ERROR diagnostic")
					map("n", "]e", function()
						require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
					end, "Next ERROR diagnostic")

					--------------------------------------------------------------------
					-- Outline / Call hierarchy
					--------------------------------------------------------------------
					map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", "Toggle outline")
					map("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", "Incoming calls")
					map("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", "Outgoing calls")

					--------------------------------------------------------------------
					-- Utilities
					--------------------------------------------------------------------
					map("n", "<leader>q", "<cmd>Lspsaga close<CR>", "Close Saga window")
					map({ "n", "t" }, "<leader>tt", "<cmd>Lspsaga term_toggle<CR>", "Toggle floating terminal")
				end,
			})
		end,
	},
}
