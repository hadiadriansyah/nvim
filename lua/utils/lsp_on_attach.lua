return function(client, bufnr)
  local bufmap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end
  bufmap("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  bufmap("n", "gr", vim.lsp.buf.references, "References")
  bufmap("n", "K",  vim.lsp.buf.hover, "Hover")
  bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  bufmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  bufmap("n", "<leader>fd", function() vim.lsp.buf.format({ async = true }) end, "Format Doc")
end
