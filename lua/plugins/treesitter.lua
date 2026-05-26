return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "html",
        "comment",
        "powershell",
        "tsx",
        "css",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "jsx",
        "typescript",
        "vim",
        "yaml",
      },
      ignore_install = {},
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
      sync_install = false,
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "lewis6991/async.nvim",
    },
    config = function(_, opts)
      local refactoring = require("refactoring")
      refactoring.setup(opts)

      --stylua: ignore
    end,
  },
}
