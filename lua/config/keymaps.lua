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
n("<leader>w", ":w<CR>", "Save")
nv("<leader>y", [["+y]], "Yank to system clipboard")
nv("<leader>p", [["+p]], "Paste from system clipboard")

-- ======================
-- Neo-tree
-- ======================
n("<leader>e", "<cmd>Neotree toggle left<CR>", "Neo-tree: Toggle")
n("<leader>o", "<cmd>Neotree focus left<CR>",  "Neo-tree: Focus")

-- ======================
-- Git (Fugitive)
-- ======================
n("<leader>gs", "<cmd>Git<cr>",				"Git Status")
n("<leader>gc", "<cmd>Git commit<cr>",			"Git Commit")
n("<leader>gp", "<cmd>Git push<cr>",			"Git Push")
n("<leader>gl", "<cmd>Git pull<cr>",			"Git Pull")
n("<leader>gb", "<cmd>Gblame<cr>",			"Git Blame")

-- ======================
-- Gitsigns
-- Use command form so it's safe even if plugin is lazy-loaded
-- ======================   
n("]c", "<cmd>Gitsigns next_hunk<cr>",			"Next Hunk")
n("[c", "<cmd>Gitsigns prev_hunk<cr>",			"Prev Hunk")
nv("<leader>hs", ":Gitsigns stage_hunk<cr>",		"Stage Hunk")
nv("<leader>hr", ":Gitsigns reset_hunk<cr>",		"Reset Hunk")
n("<leader>hS", "<cmd>Gitsigns stage_buffer<cr>",	"Stage Buffer")
n("<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>",	"Undo Stage Hunk")
n("<leader>hR", "<cmd>Gitsigns reset_buffer<cr>",	"Reset Buffer")
n("<leader>hp", "<cmd>Gitsigns preview_hunk<cr>",	"Preview Hunk")
n("<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, "Blame Line (full)")
n("<leader>ht", "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Line Blame")
n("<leader>hw", "<cmd>Gitsigns toggle_word_diff<cr>",	"Toggle Word Diff")

-- ======================
-- Diffview
-- ======================
n("<leader>gd", "<cmd>DiffviewOpen<cr>",		"Diffview Open")
n("<leader>gD", "<cmd>DiffviewClose<cr>",		"Diffview Close")
n("<leader>gH", "<cmd>DiffviewFileHistory %<cr>",	"File History (current file)")
n("<leader>gA", "<cmd>DiffviewFileHistory<cr>",		"Repo History")

-- ======================
-- Which-key groups (modern API)
-- ======================
do
  local ok, wk = pcall(require, "which-key")
  if ok then
    wk.add({
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunk (gitsigns)" },
    })
  end
end
