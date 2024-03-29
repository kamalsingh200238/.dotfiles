return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.catppuccin" },
  { "catppuccin", event = "VeryLazy" },
  { import = "astrocommunity.colorscheme.everforest" },
  { "sainnhe/everforest", event = "VeryLazy" },
  { import = "astrocommunity.colorscheme.gruvbox-baby" },
  { "luisiacc/gruvbox-baby", event = "VeryLazy" },
  { import = "astrocommunity.colorscheme.melange-nvim" },
  { "savq/melange-nvim", event = "VeryLazy" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { "EdenEast/nightfox.nvim", event = "VeryLazy" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { "olimorris/onedarkpro.nvim", event = "VeryLazy" },
  { import = "astrocommunity.colorscheme.rose-pine" },
  { "rose-pine", event = "VeryLazy" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { "folke/tokyonight.nvim", event = "VeryLazy" },

  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.tailwindcss" },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      opts.formatting.fields = { "abbr", "kind" }
      opts.preselect = cmp.PreselectMode.Item
      opts.mapping["<CR>"] = cmp.mapping.confirm { select = true }
      opts.mapping["<Tab>"] = nil
      opts.mapping["<S-Tab>"] = nil
      opts.mapping["<C-k>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })
      opts.mapping["<C-j>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" })
      return opts
    end,
  },
  { import = "astrocommunity.pack.templ" },

  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-surround" },

  { import = "astrocommunity.utility.noice-nvim" },

  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.yanky-nvim" },

  { import = "astrocommunity.project.nvim-spectre" },
}
