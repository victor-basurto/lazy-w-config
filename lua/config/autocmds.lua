-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local api = vim.api

api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt.conceallevel = 1
  end,
})
api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt.conceallevel = 1
    vim.opt_local.modifiable = true
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*/templates/*",
  callback = function()
    vim.b.autoformat = false
  end,
})
-- creating new notes from template
-- api.nvim_create_user_command("ObsidianNewFromTemplate", function(opts)
--   local template_args = opts.args
--   if template_args and template_args ~= "" then
--     vim.cmd("ObsidianNew " .. opts.args) -- Try passing the template name directly (check Obsidian docs)
--   else
--     vim.cmd("ObsidianNew")
--   end
-- end, { nargs = "?" })
