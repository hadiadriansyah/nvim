return {
  { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function()
      return require("utils.init").exists("make")
    end,
  },
  { "nvim-telescope/telescope-ui-select.nvim", version = "*" },
  { "nvim-telescope/telescope-live-grep-args.nvim", version = "*" },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local t = require("telescope")
      t.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous"
            }
          }
        },
        pickers = {},
        extensions = {},
      })

      -- Load extensions
      pcall(t.load_extension, "fzf")
      pcall(t.load_extension, "ui-select")
      pcall(t.load_extension, "live_grep_args")

      -- Keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help Tags" })
      vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope: Git Files" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Telescope: Commands" })
    end,
  },
}

