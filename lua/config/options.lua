-- options.lua
local o = vim.opt

-- General
o.number = true
o.relativenumber = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.swapfile = false

-- UI/UX
o.termguicolors = true
o.signcolumn = "yes"
o.cursorline = true

-- Searching
o.ignorecase = true
o.smartcase = true

-- Tabs/Indent
-- o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

-- Performance
o.updatetime = 200
o.timeoutlen = 400
