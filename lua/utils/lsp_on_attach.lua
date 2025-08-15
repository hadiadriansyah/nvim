return function(client, bufnr)
	local bufmap = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	-- Keep only non-UI / generic things here
	-- Use Lspsaga for UI: hover, rename, code actions, diagnostics, etc.

	-- Format document
	bufmap("n", "<leader>fd", function()
		-- Use async format to avoid blocking UI
		vim.lsp.buf.format({ async = true })
	end, "Format document")
end
