return {
	{
		"neovim/nvim-lspconfig",
		ft = { "php", "blade" },
		opts = {},
		config = function()
			local lspconfig = require("lspconfig")
			local caps = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = require("utils.lsp_on_attach")

			lspconfig.intelephense.setup({
				capabilities = caps,
				on_attach = on_attach,
				init_options = { licenceKey = nil },
				settings = {
					intelephense = {
						files = { maxSize = 2000000 },
						environment = { phpVersion = "8.2" },
						stubs = {
							"apache",
							"bcmath",
							"bz2",
							"calendar",
							"Core",
							"curl",
							"date",
							"dom",
							"fileinfo",
							"filter",
							"gd",
							"gettext",
							"hash",
							"iconv",
							"imap",
							"intl",
							"json",
							"libxml",
							"mbstring",
							"mcrypt",
							"mysql",
							"mysqli",
							"pdo",
							"pdo_mysql",
							"pgsql",
							"pdo_pgsql",
							"openssl",
							"pcntl",
							"pcre",
							"PDO",
							"Phar",
							"readline",
							"Reflection",
							"session",
							"SimpleXML",
							"sockets",
							"sodium",
							"SPL",
							"standard",
							"tokenizer",
							"xml",
							"xmlreader",
							"xmlwriter",
							"xdebug",
							"zip",
							"zlib",
						},
					},
				},
			})

			-- Blade
			lspconfig.blade.setup({
				capabilities = caps,
				on_attach = on_attach,
				filetypes = { "blade" },
			})
		end,
	},
}
