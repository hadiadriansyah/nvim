-- lua/plugins/git.lua
return {
  -- ======================
  -- GITSIGNS (status per baris, stage/reset hunk)
  -- ======================
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      signs_staged_enable = true,
      signcolumn = true,

      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 800,
        ignore_whitespace = false,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",

      attach_to_untracked = false,
      max_file_length = 40000,
      update_debounce = 100,
      sign_priority = 6,

      preview_config = {
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)

      -- Global keymaps (aman untuk lazy-loaded; pakai :Gitsigns ...)
      local map = vim.keymap.set
      local o   = { noremap = true, silent = true }

      -- Navigasi hunk
      map("n", "]c", "<cmd>Gitsigns next_hunk<cr>", vim.tbl_extend("force", o, { desc = "Next Hunk" }))
      map("n", "[c", "<cmd>Gitsigns prev_hunk<cr>", vim.tbl_extend("force", o, { desc = "Prev Hunk" }))

      -- Stage / reset hunk & buffer
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<cr>", vim.tbl_extend("force", o, { desc = "Stage Hunk" }))
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<cr>", vim.tbl_extend("force", o, { desc = "Reset Hunk" }))
      map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>",  vim.tbl_extend("force", o, { desc = "Stage Buffer" }))
      map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", vim.tbl_extend("force", o, { desc = "Undo Stage Hunk" }))
      map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>",  vim.tbl_extend("force", o, { desc = "Reset Buffer" }))
      map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>",  vim.tbl_extend("force", o, { desc = "Preview Hunk" }))

      -- Blame & word diff
      map("n", "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end,
        vim.tbl_extend("force", o, { desc = "Blame Line (full)" }))
      map("n", "<leader>ht", "<cmd>Gitsigns toggle_current_line_blame<cr>",
        vim.tbl_extend("force", o, { desc = "Toggle Line Blame" }))
      map("n", "<leader>hw", "<cmd>Gitsigns toggle_word_diff<cr>",
        vim.tbl_extend("force", o, { desc = "Toggle Word Diff" }))
    end,
  },

  -- ======================
  -- DIFFVIEW (review diff & riwayat)
  -- ======================
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewLog" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diffview Open" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>",         desc = "Diffview Close" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
      { "<leader>gA", "<cmd>DiffviewFileHistory<cr>",   desc = "Repo History" },
    },
  },

  -- ======================
  -- FUGITIVE (Git commands + stash/restore/unstage)
  -- ======================
  {
		"tpope/vim-fugitive",
		cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Gblame" },

		init = function()
			-- Expose Which-Key groups early
			local ok_wk, wk = pcall(require, "which-key")
			if ok_wk then
				wk.add({
					{ "<leader>g",  group = "Git" },
					{ "<leader>gS", group = "Stash" }, -- moved stash group under gS
					{ "<leader>h",  group = "Hunk (gitsigns)" },
				})
			end
		end,

		-- Use keys so pressing them auto-loads fugitive
		keys = {
			-- Make Git Status fire immediately (do not wait for longer sequences)
			{ "<leader>gs", "<cmd>Git<cr>", 				desc = "Git Status", nowait = true },
			{ "<leader>gc", "<cmd>Git commit<cr>", 	desc = "Git Commit" },
			{ "<leader>gp", "<cmd>Git push<cr>",   	desc = "Git Push" },
			{ "<leader>gl", "<cmd>Git pull<cr>",   	desc = "Git Pull" },
			{ "<leader>gb", "<cmd>Gblame<cr>",     	desc = "Git Blame" },
      { "<leader>ga", "<cmd>Git add .<cr>",  	desc = "Git Add ALL files" },
      { "<leader>gA", function()
          local f = vim.fn.expand("%")
          if f == "" then
            return vim.notify("No file name (empty buffer)", vim.log.levels.WARN)
          end
          vim.cmd("Git add " .. vim.fn.fnameescape(f))
        end,
        desc = "Git Add current file"
      },

			-- Stash group moved to gS (uppercase S)
			{ "<leader>gSl", "<cmd>Git stash list<cr>",  desc = "Stash: List" },
			{ "<leader>gSa", "<cmd>Git stash apply<cr>", desc = "Stash: Apply latest" },
			{ "<leader>gSp", "<cmd>Git stash pop<cr>",   desc = "Stash: Pop latest" },
			{ "<leader>gSd", "<cmd>Git stash drop<cr>",  desc = "Stash: Drop latest" },

			-- (Optional) Diffview under Git group
			{ "<leader>gdo", "<cmd>DiffviewOpen<cr>",          desc = "Diffview: Open" },
			{ "<leader>gdc", "<cmd>DiffviewClose<cr>",         desc = "Diffview: Close" },
			{ "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File History (current)" },
			{ "<leader>gdr", "<cmd>DiffviewFileHistory<cr>",   desc = "Diffview: Repo History" },
		},

		config = function()
			local map, o = vim.keymap.set, { noremap = true, silent = true }

			-- Stash with prompt (under gS)
			map("n", "<leader>gSs", function()
				-- Ask for stash message; include untracked (-u)
				vim.ui.input({ prompt = "Stash message (optional): " }, function(msg)
					if msg == nil or msg == "" then
						vim.cmd("Git stash push -u")
					else
						vim.cmd("Git stash push -u -m " .. vim.fn.shellescape(msg))
					end
				end)
			end, vim.tbl_extend("force", o, { desc = "Stash: Save (include untracked)" }))

			-- Apply/Pop specific via picker (under gS)
			local function pick_stash(cb)
				-- Build a list of stashes like "stash@{0}: message"
				local lines = vim.fn.systemlist({ "git", "stash", "list", "--format=%gd:%s" })
				if vim.v.shell_error ~= 0 or #lines == 0 then
					return vim.notify("No stashes found", vim.log.levels.WARN)
				end
				vim.ui.select(lines, { prompt = "Select stash:" }, function(item)
					if not item then return end
					local id = item:match("^(stash@{%d+})")
					if not id then return vim.notify("Failed to parse stash id", vim.log.levels.ERROR) end
					cb(id)
				end)
			end

			map("n", "<leader>gSA", function() pick_stash(function(id) vim.cmd("Git stash apply " .. id) end) end,
				vim.tbl_extend("force", o, { desc = "Stash: Apply specific" }))
			map("n", "<leader>gSP", function() pick_stash(function(id) vim.cmd("Git stash pop " .. id) end) end,
				vim.tbl_extend("force", o, { desc = "Stash: Pop specific" }))

			-- Unstage / restore
			map("n", "<leader>gu", "<cmd>Git restore --staged .<cr>", vim.tbl_extend("force", o, { desc = "Unstage ALL files" }))
			map("n", "<leader>gU", function()
				local f = vim.fn.expand("%")
				if f == "" then return vim.notify("No file name (empty buffer)", vim.log.levels.WARN) end
				vim.cmd("Git restore --staged " .. vim.fn.fnameescape(f))
			end, vim.tbl_extend("force", o, { desc = "Unstage current file" }))
			map("n", "<leader>gR", function()
				vim.ui.select({ "No", "Yes (discard ALL changes)" }, { prompt = "Restore working tree to HEAD?" }, function(choice)
					if choice == "Yes (discard ALL changes)" then
						vim.cmd("Git restore ."); vim.notify("Working tree restored to HEAD", vim.log.levels.INFO)
					end
				end)
			end, vim.tbl_extend("force", o, { desc = "Restore ALL (discard changes)" }))
			map("n", "<leader>gRB", function()
				vim.ui.input({ prompt = "Backup stash message (optional): " }, function(msg)
					if msg == nil or msg == "" then vim.cmd("Git stash push -u")
					else vim.cmd("Git stash push -u -m " .. vim.fn.shellescape(msg)) end
					vim.cmd("Git restore ."); vim.notify("Backed up (stash) and restored working tree", vim.log.levels.INFO)
				end)
			end, vim.tbl_extend("force", o, { desc = "Backup & Restore (stash then discard)" }))
		end,
	}
}

