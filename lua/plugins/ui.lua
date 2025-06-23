return {
  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
        ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗███████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
        ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔════╝    ████╗  ██║██║   ██║██║████╗ ████║
        ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║███████╗    ██╔██╗ ██║██║   ██║██║██╔████╔██║
        ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║╚════██║    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
        ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝███████║    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                                                                          
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
  {
    "folke/edgy.nvim",
    ---@module 'edgy'
    ---@param opts Edgy.Config
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
      ---@class snacks.terminal.Config
      ---@field win? snacks.win.Config|{}
      ---@field shell? string|string[] The shell to use. Defaults to `vim.o.shell`
      ---@field override? fun(cmd?: string|string[], opts?: snacks.terminal.Opts) Use this to use a different terminal implementation
      opts.terminal = {
        win = {
          style = "terminal",
        },
      }
    end,
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  { "bullets-vim/bullets.vim" },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },
  { "echasnovski/mini.icons" },

  -- WARNING: Plugins below are currently disabled due to broken functionality or
  -- not useful in my configuration. Consider REMOVE

  -- BUG: stay-centered is broken when mapping `gg` | `G`
  {
    "arnamak/stay-centered.nvim",
    enabled = false,
    config = function()
      require("stay-centered").setup({
        -- The filetype is determined by the vim filetype, not the file extension. In order to get the filetype, open a file and run the command:
        -- :lua print(vim.bo.filetype)
        skip_filetypes = {},
        -- Set to false to disable by default
        enabled = true,
        -- allows scrolling to move the cursor without centering, default recommended
        allow_scroll_move = true,
        -- temporarily disables plugin on left-mouse down, allows natural mouse selection
        -- try disabling if plugin causes lag, function uses vim.on_key
        disable_on_mouse = true,
      })
    end,
  },
}
