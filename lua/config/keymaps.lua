-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Helper mapping functions
local map = vim.keymap.set
local base_opts = { noremap = true, silent = true }
local function n(lhs, rhs, desc) map("n", lhs, rhs, vim.tbl_extend("force", base_opts, { desc = desc })) end
local function nv(lhs, rhs, desc) map({ "n", "v" }, lhs, rhs, vim.tbl_extend("force", base_opts, { desc = desc })) end

-- ======================
-- General
-- ======================
n("<leader>q", ":q<CR>", "Quit")
n("<leader>qa", ":qa<CR>", "Quit All (safe)")
n("<leader>qA", ":qa!<CR>", "Quit All (force)")
n("<leader>w", ":w<CR>", "Save")
nv("<leader>y", [["+y]], "Yank to system clipboard")
nv("<leader>p", [["+p]], "Paste from system clipboard")

-- ======================
-- Neo-tree
-- ======================
n("<leader>e", "<cmd>Neotree toggle left<CR>", "Neo-tree: Toggle")
n("<leader>o", "<cmd>Neotree focus left<CR>",  "Neo-tree: Focus")
