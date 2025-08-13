return {
  -- Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        }
      })
      vim.cmd.colorscheme "tokyonight"
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
  },
  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
        }
      },
      window = {
        width = 24,
        mappings = {
          ["z"]  = "none",
          ["zc"] = "close_node",
          ["zo"] = "open",
          ["zM"] = "close_all_nodes",
          ["zO"] = "expand_all_nodes",
          ["l"] = "open",
          ["h"] = "close_node",
          ["o"] = "open",
          ["<cr>"] = "open",
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      vim.cmd("Neotree filesystem reveal left")
    end,
  },
  -- Hint Keymap
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- notifikasi
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 1500
    }
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight"
      }
    }
  },
}
