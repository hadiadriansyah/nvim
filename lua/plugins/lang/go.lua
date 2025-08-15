return {
	{
		"neovim/nvim-lspconfig",
		ft = { "go", "gomod", "gosum", "gotmpl" },
		config = function()
			local lspconfig = require("lspconfig")
			local caps = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = require("utils.lsp_on_attach")
			lspconfig.gopls.setup({
				capabilities = caps,
				on_attach = on_attach,
				settings = {
					gopls = {
						analyses = { unusedparams = true, nilness = true, unusedwrite = true },
						staticcheck = true,
					},
				},
			})
		end,
	},
}
