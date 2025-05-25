-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },

      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- custom settings
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.colorcolumn = "80"

-- custom keymaps
-- Neotree toggle
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle File Explorer" })

-- quit all
vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit all" })

-- Harpoon keymaps
local map = vim.keymap.set

-- Map <leader>e to open Harpoon menu (using Telescope if available)
map("n", "<leader>h", function()
require("telescope").extensions.harpoon.marks()
end, { desc = "Open Harpoon Menu" })

-- Optional: Additional Harpoon keymaps for marking and navigating files
map("n", "<leader>ha", function()
require("harpoon"):list():append()
end, { desc = "Harpoon: Add file" })
map("n", "<leader>1", function()
require("harpoon"):list():select(1)
end, { desc = "Harpoon: Go to file 1" })
map("n", "<leader>2", function()
require("harpoon"):list():select(2)
end, { desc = "Harpoon: Go to file 2" })
map("n", "<leader>3", function()
require("harpoon"):list():select(3)
end, { desc = "Harpoon: Go to file 3" })
map("n", "<leader>4", function()
require("harpoon"):list():select(4)
end, { desc = "Harpoon: Go to file 4" })

-- Tab functionality in nvim
-- Map Ctrl+Right to next tab
vim.keymap.set("n", "<C-Right>", ":tabnext<CR>", { noremap = true, silent = true })
-- Map Ctrl+Left to previous tab
vim.keymap.set("n", "<C-Left>", ":tabprevious<CR>", { noremap = true, silent = true })
-- Map Ctrl+t to open a new tab
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { noremap = true, silent = true })
-- Map Ctrl+w to close current tab
vim.keymap.set("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },

  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
