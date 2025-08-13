return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua","vim","vimdoc",
        "php","blade","javascript","typescript","tsx",
        "html","css","json","yaml","markdown","markdown_inline",
        "bash","dockerfile","ini","nginx",
        "go","gomod","gosum",
        "java","kotlin",
        "sql",
      },
      highlight = { enable = true },
      incremental_selection = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end
  },
}
