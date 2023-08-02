return {
  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  --
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        -- "           ▄ ▄                   ",
        -- "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
        -- "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
        -- "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
        -- "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
        -- "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
        -- "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
        -- "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
        -- "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
        -- " █████  ███████ ████████ ██████   ██████",
        -- "██   ██ ██         ██    ██   ██ ██    ██",
        -- "███████ ███████    ██    ██████  ██    ██",
        -- "██   ██      ██    ██    ██   ██ ██    ██",
        -- "██   ██ ███████    ██    ██   ██  ██████",
        -- " ",
        -- "    ███    ██ ██    ██ ██ ███    ███",
        -- "    ████   ██ ██    ██ ██ ████  ████",
        -- "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        -- "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        -- "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  {
    -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local lspkind = require "lspkind"
      local format_kinds = lspkind.cmp_format {
        mode = "symbol_text", -- show only symbol annotations
        maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        -- before = function (entry, vim_item)
        --   ...
        --   return vim_item
        -- end
      }
      opts.formatting = {
        fields = { "abbr", "kind" },
        format = function(entry, item)
          format_kinds(entry, item)
          return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end,
      }
      opts.preselect = cmp.PreselectMode.Item
      -- modify the mapping part of the table
      -- opts.mapping["<Cr>"] = cmp.mapping.select_next_item()
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

      -- return the new table to be used
      return opts
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      opts.defaults.mappings.i = {
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
      }
      return opts
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem.filtered_items = {
        hide_dotfiles = false,
        -- hide_hidden = false, -- only works on Windows for hidden files/directories
      }
      -- opts.window.position = "right"
      return opts
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = { "lua_ls", "tsserver", "tailwindcss" },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = { "prettier", "stylua" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      -- ensure_installed = { "python" },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function(_, opts)
      opts.char = "▎"
      opts.context_char = "▎"
      return opts
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = function(_, opts)
      opts.user_default_options = { tailwind = true }
      return opts
    end,
  },
}
