-- autocmds.lua
local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Highlight on yank
au("TextYankPost", { group = aug("Yank", {}), callback = function() vim.highlight.on_yank() end })

---- Lint on save
--au({"BufWritePost"}, {
--  group = aug("LintOnSave", {}),
--  callback = function()
--    require("lint").try_lint()
--  end,
--})
