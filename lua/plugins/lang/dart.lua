return {
	{
		"akinsho/flutter-tools.nvim",
		ft = { "dart" },
		dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
		opts = {
			widget_guides = { enabled = true },
			lsp = {
				color = { enabled = true },
				on_attach = require("utils.lsp_on_attach"),
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			},
			debugger = { enabled = true }, -- pakai dart debug adapter
		},
	},
}
