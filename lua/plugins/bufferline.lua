-- lua/plugins/tabs.lua
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy", -- load after UI is ready
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- filetype icons
			"echasnovski/mini.bufremove", -- safer buffer close (no window layout jump)
		},

		-- Show groups in Which-Key early (optional)
		init = function()
			-- Ensure truecolor for proper highlights
			vim.opt.termguicolors = true

			local ok, wk = pcall(require, "which-key")
			if ok then
				wk.add({
					{ "<leader>b", group = "Buffers" },
					{ "<leader>t", group = "Tabs" }, -- native tabpage group (optional)
				})
			end
		end,

		opts = {
			options = {
				-- Show buffers (files) as tabs
				mode = "buffers",

				-- Integrate with Neo-tree / Diffview (adds left offset/header)
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "DiffviewFiles",
						text = "Diffview",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "Outline",
						text = "Symbols Outline",
						highlight = "Directory",
						text_align = "left",
					},
				},

				-- Use safe buffer remove so window layout is preserved
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				right_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				show_close_icon = false,
				show_buffer_close_icons = true,
				separator_style = "slant",
				hover = { enabled = true, delay = 100, reveal = { "close" } },
				sort_by = "insert_after_current",
			},
		},

		-- Keys here both show in Which-Key and lazy-load the plugin on first press
		keys = {
			-- Navigate buffers (tabs)
			{ "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
			{ "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },

			-- Re-order buffers
			{ "<leader>b]", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
			{ "<leader>b[", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },

			-- -- Direct jump (1..9)
			-- { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
			-- { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
			-- { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
			-- { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
			-- { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
			-- { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
			-- { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
			-- { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
			-- { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },

			-- Pick buffer by letter
			{ "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },

			-- Close buffer safely (keep window layout)
			{
				"<leader>bc",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Close buffer",
			},
			{
				"<leader>bC",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Close buffer (force)",
			},

			-- Close ALL buffers but stay in Neovim
			{
				"<leader>bA",
				function()
					local bufremove = require("mini.bufremove")

					-- Create an empty buffer so Neovim doesn't exit
					vim.cmd("enew")

					-- Detect Neo-tree buffer to keep
					local keep_bufs = { vim.api.nvim_get_current_buf() }
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[buf].filetype == "neo-tree" then
							table.insert(keep_bufs, buf)
						end
					end

					-- Delete all listed buffers except current and Neo-tree
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[bufnr].buflisted and not vim.tbl_contains(keep_bufs, bufnr) then
							pcall(bufremove.delete, bufnr, false) -- false = safe delete
						end
					end
				end,
				desc = "Buffers: close ALL (safe, keep Neo-tree)",
			},
			{
				"<leader>bF",
				function()
					local bufremove = require("mini.bufremove")

					-- Create an empty buffer so Neovim doesn't exit
					vim.cmd("enew")

					-- Detect Neo-tree buffer to keep
					local keep_bufs = { vim.api.nvim_get_current_buf() }
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[buf].filetype == "neo-tree" then
							table.insert(keep_bufs, buf)
						end
					end

					-- Force delete all listed buffers except current and Neo-tree
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[bufnr].buflisted and not vim.tbl_contains(keep_bufs, bufnr) then
							pcall(bufremove.delete, bufnr, true) -- true = force delete
						end
					end
				end,
				desc = "Buffers: close ALL (force, keep Neo-tree)",
			},
			-- Close OTHER buffers (keep only the current buffer)
			{
				"<leader>bo",
				function()
					-- Close all listed buffers except the current one (safe delete)
					local bufremove = require("mini.bufremove")
					local current = vim.api.nvim_get_current_buf()
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[bufnr].buflisted and bufnr ~= current then
							pcall(bufremove.delete, bufnr, false) -- false = safe delete
						end
					end
				end,
				desc = "Buffers: close OTHERS (safe, keep current only)",
			},

			-- Close OTHER buffers but keep Neo-tree (if you want the file explorer to stay)
			{
				"<leader>bO",
				function()
					-- Close all listed buffers except the current one and Neo-tree (safe delete)
					local bufremove = require("mini.bufremove")
					local current = vim.api.nvim_get_current_buf()
					local keep_fts = { "neo-tree" } -- add more filetypes if you want to keep them
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						local ft = vim.bo[bufnr].filetype
						if vim.bo[bufnr].buflisted and bufnr ~= current and not vim.tbl_contains(keep_fts, ft) then
							pcall(bufremove.delete, bufnr, false)
						end
					end
				end,
				desc = "Buffers: close OTHERS (safe, keep current + Neo-tree)",
			},

			-- Force variant (use when some buffers are modified/blocked)
			{
				"<leader>bf",
				function()
					-- Force close all listed buffers except the current one
					local bufremove = require("mini.bufremove")
					local current = vim.api.nvim_get_current_buf()
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[bufnr].buflisted and bufnr ~= current then
							pcall(bufremove.delete, bufnr, true) -- true = force delete
						end
					end
				end,
				desc = "Buffers: close OTHERS (force, keep current only)",
			},
		},
	},
}
