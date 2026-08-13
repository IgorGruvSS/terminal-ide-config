-- Bootstrap lazy.nvim, LazyVim, official Extras, and local overrides.
require("config.lazy")

-- LazyVim normally defers these modules until `VeryLazy`, which only follows
-- `UIEnter`. Load the defaults first and then our overrides so the core
-- editing behaviour is also available in headless starts and before a UI
-- attaches. `require` keeps LazyVim's later `VeryLazy` pass idempotent.
require("lazyvim.config.autocmds")
require("config.autocmds")
require("lazyvim.config.keymaps")
require("config.keymaps")

-- Keep theme synchronization here, after the LazyVim colorscheme bootstrap.
require("theme-sync")
