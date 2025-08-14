return {
  { "stevearc/conform.nvim", version = "*",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        php = { "php_cs_fixer" },
        blade = { "blade-formatter" },
        go = { "gofumpt", "goimports" },
        sql = { "sql-formatter" },
        java = { "google-java-format" },
      },
      format_on_save = { timeout_ms = 2000, lsp_fallback = true },
    },
  },
  { "mfussenegger/nvim-lint", version = "*",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        php = { "phpstan" }, -- or "psalm"
        go = { "golangci_lint" },
        dockerfile = { "hadolint" },
        yaml = { "yamllint" },
        sql = { "sqlfluff" },
      }
    end,
  },
}
