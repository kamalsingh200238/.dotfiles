local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  print("cmp not installed")
  return
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  print("lspkind not installed")
  return
end

lspkind.init()

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local cmp_mapping = cmp.mapping.preset.insert({
  ["<C-n>"] = cmp.mapping.select_next_item(),
  ["<C-p>"] = cmp.mapping.select_prev_item(),
  ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
  ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
  ["<C-d>"] = cmp.mapping.scroll_docs(-1),
  ["<C-f>"] = cmp.mapping.scroll_docs(1),
  ["<C-e>"] = cmp.mapping.abort(),
  ["<CR>"] = cmp.mapping(
    cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    { "i", "c" }
  ),
  ["<C-y>"] = cmp.mapping(
    cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    { "i", "c" }
  ),
  ["<C-space>"] = cmp.mapping({
    i = cmp.mapping.complete(),
    c = function(
      _ --[[fallback]]
    )
      if cmp.visible() then
        if not cmp.confirm({ select = true }) then
          return
        end
      else
        cmp.complete()
      end
    end,
  }),
})

cmp.setup({
  mapping = cmp_mapping,
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      },
    }),
  },
  sources = {
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "luasnip" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = {
      border = border("CmpBorder"),
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border("CmpDocBorder"),
    },
  },
})
