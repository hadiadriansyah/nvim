return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			return opts
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				-- PHP
				"intelephense",
				"emmet_ls",
				-- JS/TS/React/Next
				"ts_ls",
				"eslint",
				"tailwindcss",
				"html",
				"cssls",
				"jsonls",
				"yamlls",
				-- Go
				"gopls",
				-- Java
				"jdtls",
				-- SQL & DevOps
				"sqlls",
				"bashls",
				"dockerls",
				-- Lua
				"lua_ls",
			},
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		enabled = false, -- kita pakai conform + nvim-lint
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- formatters
				"prettier",
				"stylua",
				"pint",
				"php-cs-fixer",
				"jq",
				"pgformatter",
				"gofumpt",
				"goimports-reviser",
				"google-java-format",
				-- linters
				"eslint_d",
				"golangci-lint",
				"hadolint",
				"yamllint",
				"phpcs",
			},
			run_on_start = true,
		},
	},
}
