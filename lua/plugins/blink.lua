return {
  {

    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    enabled = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
  },
  {
    "saghen/blink.cmp",
    enabled = true,
    build = vim.fn.has("win32") == 1 and 'pwsh -c "cargo build --release"' or "cargo build --release",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    dependencies = {
      "moyiz/blink-emoji.nvim",
      "Kaiser-Yang/blink-cmp-dictionary",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
      {
        "catppuccin",
        optional = true,
        opts = {
          integrations = { blink_cmp = true },
        },
      },
    },
    event = "InsertEnter",
  },
}
