return {
-- GITSIGNS (status perubahan per baris + stage/reset hunk)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- Gutter symbols for git changes
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },

    -- Show different symbols for staged changes
    signs_staged_enable = true,

    -- Always display the sign column
    signcolumn = true,

    -- Line blame (OFF by default, can be toggled when needed)
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 800,           -- delay in ms before blame is shown
      ignore_whitespace = false,
      use_focus = true,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",

    -- Performance & stability options
    attach_to_untracked = false,
    max_file_length = 40000, -- disable gitsigns if file exceeds this length (lines)
    update_debounce = 100,   -- debounce updates for performance
    sign_priority = 6,       -- priority for displaying signs

    -- Popup preview for hunks
    preview_config = {
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    }, 
  },

  -- DIFFVIEW (review diff & riwayat)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewLog" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- FUGITIVE (git commands cepat, stabil)
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Gblame" },
  },
}
