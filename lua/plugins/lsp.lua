return {
  { "williamboman/mason.nvim", build = ":MasonUpdate", opts = { ui = { border = "rounded" } } },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" }, opts = { automatic_installation = true } },
  { "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_caps = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = require("utils.lsp_on_attach")

      -- Server generic
      local servers = {
        lua_ls = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
        dockerls = {},
        html = {},
        cssls = {},
        emmet_ls = {},
        tailwindcss = {},
      }

      -- Apply generic
      for name, opts in pairs(servers) do
        opts.capabilities = cmp_caps
        opts.on_attach = on_attach
        lspconfig[name].setup(opts)
      end
    end
  },
}
