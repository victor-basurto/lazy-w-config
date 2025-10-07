-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }
local keymap = vim.keymap

-- discipline, custom plugin inspired by `craftzdog-max/devaslife`
local discipline = require("utilities.discipline")
discipline.strictMode()

-- telescope
local telescopeBuiltin = require("telescope.builtin")
local telescope = require("telescope")
keymap.set("n", "<leader>ff", telescopeBuiltin.find_files, { desc = "Telescope find files" })
keymap.set("n", "<leader>fg", telescopeBuiltin.live_grep, { desc = "Telescope live grep" })
keymap.set("n", "<leader>fb", telescopeBuiltin.buffers, { desc = "Telescope buffers" })
keymap.set("n", "<leader>fh", telescopeBuiltin.help_tags, { desc = "Telescope help tags" })
keymap.set("n", "<leader>fi", telescopeBuiltin.resume, { desc = "Telescope resume" })
keymap.set("n", "<leader>fj", telescopeBuiltin.diagnostics, { desc = "Telescope diagnostics" })
keymap.set("n", "<leader>fk", telescopeBuiltin.treesitter, { desc = "Telescope treesitter" })
keymap.set("n", "<leader>fl", function()
  local function telescope_buffer_dir()
    return vim.fn.expand("%:p:h")
  end
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
  })
end)
-- end telescope

-- neoGen
vim.api.nvim_set_keymap("n", "<leader>ng", ":lua require('neogen').generate()<CR>", opts)

-- Increment / Decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select All
keymap.set("n", "<C-a>", "gg<S-v>G")

-- new tab
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- move windows
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.get_next({ buffer = 0, severity = vim.diagnostic.severity.ERROR })
end)

-- strikethrough command
keymap.set("n", "<leader>ts", function()
  local line = vim.fn.getline(".")
  -- get line without leading/trailing spaces
  local trimmed = line:match("^%s*(.-)%s*$")
  if trimmed == "" then
    return
  end
  -- check if already has strikethrough
  if trimmed:match("^~.*~$") then
    -- remove strikethrough
    local content = trimmed:match("^~(.*)~$")
    local indent = line:match("^(%s*)")
    vim.fn.setline(".", indent .. content)
  else
    -- add strikethrough
    local indent = line:match("^(%s*)")
    vim.fn.setline(".", indent .. "~" .. trimmed .. "~")
  end
end, { desc = "[Text strikethrough] toggle strikethrough line" })
-- obsidian
-- apply template `notes.md` to new notes
keymap.set("n", "<leader>on", ":ObsidianTemplate notes<CR> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>")
-- strip date from note title and replace dashes with spaces
keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
-- delete file in current buffer MacOs
keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")

-- Windows Keymaps
-- WOK: Move current file to zettelkasten folder
-- WOD: Delete current file in buffer

-- add keymap to move file in current buffer to zettelkasten folder
keymap.set("n", "<leader>wok", function()
  local current_file = vim.fn.expand("%:p")
  local zettelkasten_folder_expanded = vim.fn.expand("~/obsidian-work/zettelkasten")
  local filename = vim.fn.fnamemodify(current_file, ":t") -- Get just the filename
  local destination_path = zettelkasten_folder_expanded .. "\\" .. filename -- Concatenate

  if vim.fn.isdirectory(zettelkasten_folder_expanded) == 0 then
    print("Error: Zettelkasten folder does not exist: " .. zettelkasten_folder_expanded)
    return
  end
  -- Rename/Move the file
  local status = vim.fn.rename(current_file, destination_path)
  if status == 0 then
    print("File moved successfully to: " .. destination_path)
    vim.cmd(":bd") -- Close the current buffer
  else
    print("Error moving file. Status: " .. status)
  end
end, { desc = "Move current file to zettelkasten folder (PowerShell)" })
-- delete file in current buffer windows
keymap.set("n", "<leader>wod", function()
  local buffer_functions = require("utilities.delete_current_buffer_win")
  buffer_functions.del_buffer_win()
end, { desc = "Delete current buffer from system" })
-- end obsidian
