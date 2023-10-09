return {
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
}
