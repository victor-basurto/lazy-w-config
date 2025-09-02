return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = false,
      flavour = "macchiato",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    priority = 1000,
    after = "catppuccin",
    opts = function(_, opts)
      -- Your custom configuration
      if (vim.g.colors_name or ""):find("catppuccin") then
        opts.highlights = require("catppuccin.groups.integrations.bufferline").get_theme()
      end
      -- Add any other custom options here
      return opts
    end,
  },
}
